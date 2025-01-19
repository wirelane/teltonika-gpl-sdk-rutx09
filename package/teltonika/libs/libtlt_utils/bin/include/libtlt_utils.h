
#ifndef __LIBTLT_SMTP_H
#define __LIBTLT_SMTP_H

#include <libubox/list.h>

typedef enum {
	LUTIL_SUCCESS,
	LUTIL_ERROR,
} lutil_stat;

struct to_list {
	/* global list of recipients */
	struct list_head list;
	/* email address */
	char *addr;
};

struct lutil_smtp {
	/* username for authentication on SMTP server */
	char *username;
	/* password for authentication on SMTP server */
	char *password;
	/* SMTP Server address */
	char *server;
	/* SMTP server port */
	int port;
	/* secure connection. 1 - on, 0 -off */
	int tls;
	/* email subject */
	char *subject;
	/* senders email */
	char *sender;
	/* email text */
	char *message;
	/* linked list of recipients */
	struct list_head *to;
};

struct port_node {
	/* next node */
	struct port_node *next;
	/* port value */
	char *value;
};

/**
 * @brief add recipient to smtp context
 * 
 * @param ctx smtp context
 * @param recipient recipients address
 * @return lutil_stat 
 * @retval LUTIL_SUCCESS on success
 * @retval LUTIL_ERROR on error
 */
lutil_stat lutil_smtp_add_recipient(struct lutil_smtp *ctx,
				    const char *recipient)  __attribute__((deprecated("use libtlt_smtp")));

/**
 * @brief clean smtp context
 * 
 * @param ctx smtp context
 */
void lutil_smtp_free(struct lutil_smtp *ctx) __attribute__((deprecated("use libtlt_smtp")));

/**
 * @brief send email
 * 
 * @param ctx smtp context
 * @return lutil_stat 
 * @retval LUTIL_SUCCESS on success
 * @retval LUTIL_ERROR on error
 */
lutil_stat lutil_smtp_send(struct lutil_smtp *ctx) __attribute__((deprecated("use libtlt_smtp")));

/**
 * @brief Base64 encode
 * 
 * @param src Data to be encoded
 * @param len Length of the data to be encoded
 * @param out_len Pointer to output length variable, or NULL if not used
 * @return Allocated buffer of out_len bytes of encoded data,
 * or NULL on failure
 *
 * Helper for b64_encode() in libubox/utils.h. Caller is responsible for
 * freeing the returned buffer. Returned buffer is nul terminated to make
 * it easier to use as a C string. The nul terminator is not included in out_len.
 */
unsigned char *lutil_base64_encode(const unsigned char *src, size_t len,
				   size_t *out_len) __attribute__((deprecated("use libubox/utils.h")));

/**
 * @brief Base64 decode
 * 
 * @param src: Data to be decoded
 * @param len: Length of the data to be decoded
 * @param out_len: Pointer to output length variable
 * @return Allocated buffer of out_len bytes of decoded data,
 * or NULL on failure
 *
 * Caller is responsible for freeing the returned buffer. This implementation
 * is about 9.5 times faster than b64_decode() in libubox/utils.h
 */
unsigned char *lutil_base64_decode(const unsigned char *src, size_t len,
				   size_t *out_len) __attribute__((deprecated("use libubox/utils.h")));

/**
 * @brief Resolves a protocol based on a given port number.
 *
 * This function checks the predefined mapping to find the protocol associated 
 * with the specified port. If found, it returns the corresponding protocol 
 * string.
 *
 * @param port the port number as a string to resolve.
 * @return pointer to the protocol string if found; otherwise, NULL.
 */
const char *lutil_protocol_resolve(char *port);

#endif //__LIBTLT_SMTP_H
