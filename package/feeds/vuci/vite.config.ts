import { fileURLToPath, URL } from 'node:url'
import fs from 'fs'
import { defineConfig, loadEnv } from 'vite'
import vuci, { type DeviceApp } from './build/vuci-plugin'
import vue from '@vitejs/plugin-vue'
import { compression } from 'vite-plugin-compression2'
import { sentryVitePlugin } from '@sentry/vite-plugin'

const productionGzipExtensions = ['js', 'css', 'svg', 'html']

export default defineConfig(({ mode, command }) => {
  mode === 'development' && generateTypeDefinitions()
  const env = loadEnv(mode, process.cwd(), '')
  const plugins = env?.VUCI_PLUGINS?.split(' ')
  const coreApps = env?.VUCI_APPS?.split(' ')
  const proxy = {
    '/ubus': {
      target: env.VITE_PROXY || 'http://192.168.1.1'
    },
    '/api': {
      target: env.VITE_PROXY || 'http://192.168.1.1'
    },
    '/cgi-bin/': {
      target: env.VITE_PROXY || 'http://192.168.1.1'
    },
    '/views/': {
      target: env.VITE_PROXY || 'http://192.168.1.1'
    },
    '/i18n/': {
      target: env.VITE_PROXY || 'http://192.168.1.1'
    }
  }

  const customHash = env?.VUCI_BUILD_HASH || '[hash]'

  const sentryConfig = getSentryConfig(env as unknown as Env)
  return {
    root: './vuci-ui-core/src',
    envDir: '../../',
    build: {
      outDir: 'dist/www',
      cssCodeSplit: false,
      emptyOutDir: true,
      rollupOptions: {
        output: {
          manualChunks: manualChunks,
          entryFileNames: `assets/[name]-${customHash}.js`,
          chunkFileNames: `assets/[name]-${customHash}.js`,
          assetFileNames: `assets/[name]-${customHash}[extname]`
        }
      },
      sourcemap: sentryConfig.enabled
    },
    define: {
      __SENTRY_ENABLED__: sentryConfig.enabled,
      __SENTRY_ENVIRONMENT__: `'${sentryConfig.environment}'`
    },
    plugins: [
      vuci({
        minify: command === 'build',
        ...(mode === 'development' || env.IS_PREVIEW === 'true'
          ? {
              target: env.TARGET_DEVICE as DeviceApp
            }
          : { coreApps, plugins })
      }),
      vue(),
      compression({ include: new RegExp('\\.(' + productionGzipExtensions.join('|') + ')$') }),
      sentryConfig.enabled &&
        sentryVitePlugin({
          ...sentryConfig,
          telemetry: false,
          release: {
            name: sentryConfig.releaseName
          },
          errorHandler: error => {
            console.error(error)
            try {
              const fd = fs.openSync('/tmp/sentry_upload_error.txt', 'w')
              fs.writeSync(fd, error.stack || error.message)
              fs.closeSync(fd)
            } catch (err) {
              console.error(err)
            }
          }
        })
    ],
    resolve: {
      extensions: ['.cjs', '.js', '.ts', '.jsx', '.tsx', '.json', '.vue'],
      alias: {
        '@': fileURLToPath(new URL('./vuci-ui-core/src/src', import.meta.url)),
        '@ui-core': fileURLToPath(new URL('./vuci-ui-core/src/ui-core', import.meta.url)),
        '@root': fileURLToPath(new URL('.', import.meta.url)),
        '@conditional': fileURLToPath(new URL('./vuci-ui-core/src/src/components/package_components/components', import.meta.url))
      }
    },
    server: { proxy },
    preview: { proxy }
  }
})

function manualChunks(id: string) {
  if (id.includes('node_modules')) return 'vendor'
  const match = /.*vuci-app-([a-zA-Z0-9-]+)-ui/.exec(id)
  if (match) return `app.${match[1]}.app`
  return 'app'
}

// Add generator functions here
function generateTypeDefinitions() {
  try {
    generateIconDefinitions()
  } catch (e) {
    console.error(e)
    console.log('error while generating type definitions')
  }
}

function generateIconDefinitions() {
  let icons = fs.readdirSync('./vuci-ui-core/src/ui-core/tlt-design/icons/').filter(name => !/^[Tlt]|icons\.d\.ts|icon-types/.test(name))
  icons = icons.map(
    k =>
      `'${k
        .replace('Icon', '')
        .replace('.vue', '')
        .replace(/([A-Z])/g, '-$1')
        .slice(1)
        .toLowerCase()}'`
  )
  fs.writeFileSync('./vuci-ui-core/src/ui-core/tlt-design/icons/icon-types.d.ts', `export type Icon =\n  | ${icons.join('\n  | ')}\n`)
}

/**
 * Environment variables from .env file and GitLab pipelines (https://docs.gitlab.com/ee/ci/variables/predefined_variables.html)
 */
interface Env {
  /**
   * @description vuci repository hash concatenated with current build date in such format: `{date}-{hash}`
   * @example
   * '2024-10-21-867547f873'
   */
  VUCI_BUILD_HASH?: string
  /**
   * The commit revision the project is built for.
   */
  CI_COMMIT_SHA: string
  /**
   * The commit tag name. Available only in pipelines for tags.
   */
  CI_COMMIT_TAG: string
  /**
   * The commit branch name. Available in branch pipelines, including pipelines for the default branch. Not available in merge request pipelines or tag pipelines.
   */
  CI_COMMIT_BRANCH: string
  /**
   * The Sentry organization name of the associated app
   */
  SENTRY_ORG: string
  /**
   * The project name of the associated app
   */
  SENTRY_PROJECT: string
  /**
   * The Authentication token
   */
  SENTRY_AUTH_TOKEN: string
}

/**
 * Creates Sentry configuration
 * Release naming:
 * * develop and release branches - latest commit SHA
 * * master release - commit tag
 * Environments:
 * * develop branch - development
 * * release branch - release
 * * master branch - production
 */
export function getSentryConfig(env: Env) {
  const { VUCI_BUILD_HASH, CI_COMMIT_SHA, CI_COMMIT_TAG, CI_COMMIT_BRANCH, SENTRY_ORG, SENTRY_PROJECT, SENTRY_AUTH_TOKEN } = env
  const repoHash = VUCI_BUILD_HASH ? VUCI_BUILD_HASH.split('-').at(-1) : CI_COMMIT_SHA
  const dotenvConfigured = !!(SENTRY_ORG && SENTRY_PROJECT && SENTRY_AUTH_TOKEN)
  const isDevelopmentBranch = CI_COMMIT_BRANCH === 'develop'
  const isReleaseBranch = CI_COMMIT_BRANCH?.startsWith('release/')
  const isMasterBranch = !!CI_COMMIT_TAG
  return {
    org: SENTRY_ORG,
    project: SENTRY_PROJECT,
    authToken: SENTRY_AUTH_TOKEN,
    releaseName: CI_COMMIT_TAG ?? repoHash,
    enabled: dotenvConfigured && (isDevelopmentBranch || isReleaseBranch || isMasterBranch),
    environment: isMasterBranch ? 'production' : isReleaseBranch ? 'release' : 'development'
  }
}
