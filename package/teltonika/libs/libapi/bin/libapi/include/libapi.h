
#ifndef __LIBAPI_H__
#define __LIBAPI_H__

typedef enum {
	LAPI_SUCCESS = 0,
	LAPI_ERROR,
} lapi_stat;

enum lapi_method {
	LAPI_METHOD_GET = 0,
	LAPI_METHOD_POST,
	LAPI_METHOD_PUT,
	LAPI_METHOD_DELETE,
	LAPI_METHOD_UNKNOWN = 8,
};

enum lapi_access_mode {
	LAPI_MODE_UNKNOWN = 0,
	LAPI_MODE_WHITELIST,
	LAPI_MODE_BLACKLIST,
};

#define LAPI_R_ACCESS  (1 << LAPI_METHOD_GET)
#define LAPI_W_ACCESS  (1 << LAPI_METHOD_POST | 1 << LAPI_METHOD_PUT | 1 << LAPI_METHOD_DELETE)
#define LAPI_RW_ACCESS (LAPI_R_ACCESS | LAPI_W_ACCESS)

/**
 * @brief init access control list
 * 
 * @return lapi_stat 
 */
lapi_stat lapi_init(void);

/**
 * @brief destroy access control list
 * 
 */
void lapi_destroy(void);

/**
 * @brief grant access to endpoint
 * 
 * @param endpoint API endpoint
 * @param method method to access
 * @return lapi_stat LAPI_SUCCESS if access granted, LAPI_ERROR otherwise
 */
lapi_stat lapi_grant_access(const char *endpoint, enum lapi_method method);
enum lapi_method lapi_method_atoi(const char *method);

/**
 * @brief grant access to endpoint. Simplified version
 * 
 * @param endpoint API endpoint
 * @param method method to access
 * @return lapi_stat LAPI_SUCCESS if access granted, LAPI_ERROR otherwise
 */
static inline lapi_stat lapi_grant_access_simple(const char *endpoint, const char *method)
{
	return lapi_grant_access(endpoint, lapi_method_atoi(method));
}

#endif // __LIBAPI_H__
