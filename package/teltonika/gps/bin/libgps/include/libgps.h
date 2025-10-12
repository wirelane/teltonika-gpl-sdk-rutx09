#ifdef __cplusplus
extern "C" {
#endif

#pragma once

#include <libubus.h>

typedef enum {
	LGPS_SUCCESS,
	LGPS_ERROR_UBUS,
	LGPS_ERROR,
} lgps_err_t;

typedef enum {
	LGPS_FIX_Q_INVALID,
	LGPS_FIX_Q_GPS,
	LGPS_FIX_Q_DGPS,
	LGPS_FIX_Q_UNKNOWN,
} lgps_fix_quality_t;

typedef enum {
	LGPS_FIX_SET_MODE_MANUAL,
	LGPS_FIX_SET_MODE_AUTO,
	LGPS_FIX_SET_MODE_UNKNOWN,
} lgps_fix_set_mode_t;

typedef enum {
	LGPS_FIX_CURR_MODE_NONE = 1,
	LGPS_FIX_CURR_MODE_2D,
	LGPS_FIX_CURR_MODE_3D,
	LGPS_FIX_CURR_MODE_UNKNOWN,
} lgps_fix_curr_mode_t;

typedef enum {
	GPS_LONGITUDE,
	GPS_LATITUDE,
	GPS_ALTITUDE,
	GPS_ANGLE,
	GPS_SPEED,
	GPS_ACCURACY,
	GPS_SATELLITES,
	GPS_TIMESTAMP,
	GPS_FIX_QUALITY,
	GPS_FIX_CURR_MODE,
	GPS_FIX_SET_MODE,
	GPS_PDOP,
	GPS_HDOP,
	GPS_VDOP,
	GPS_TMG_TRUE,
	GPS_TMG_MAGNETIC,
	GPS_SPEED_VTG_KNOTS,
	GPS_SPEED_VTG_KMH,
	GPS_STATUS,
	GPS_UTC_TIMESTAMP,
	GPS_CONSTELLATION,
	GPS_T_MAX,
} lgps_pos_t;

typedef struct {
	double longitude;
	double latitude;
	double altitude;
	double angle;
	double speed;
	double accuracy;
	double pdop;
	double hdop;
	double vdop;
	double tmg_true; /* Track made good, degrees True */
	double tmg_magnetic; /* Track made good, degrees Magnetic */
	double speed_vtg_knots;
	double speed_vtg_kmh;
	uint32_t satellites;
	lgps_fix_quality_t fix_quality;
	lgps_fix_set_mode_t fix_set_mode;
	lgps_fix_curr_mode_t fix_curr_mode;
	uint32_t fix_status;
	uint64_t timestamp;
	uint64_t utc_timestamp;
	char constellation[2]; // Example: GP, GA, BD, GL
} lgps_t;

extern const struct blobmsg_policy g_gps_position_policy[];

lgps_err_t lgps_get_tmo(struct ubus_context *, lgps_t *, int);
lgps_err_t lgps_get(struct ubus_context *, lgps_t *);
lgps_err_t lgps_subscribe(struct ubus_context *ctx, struct ubus_subscriber *gps_sub, ubus_handler_t cb,
			  ubus_remove_handler_t rm_cb);

const char *lgps_strerror(lgps_err_t);
const char *lgps_fix_quality_to_str(lgps_fix_quality_t fix_quality);
lgps_fix_quality_t lgps_fix_quality_from_str(char fix_quality);
const char *lgps_fix_curr_mode_to_str(lgps_fix_curr_mode_t fix_mode);
lgps_fix_curr_mode_t lgps_fix_curr_mode_from_str(char fix_mode);
const char *lgps_fix_set_mode_to_str(lgps_fix_set_mode_t fix_mode);
lgps_fix_set_mode_t lgps_fix_set_mode_from_str(char fix_mode);
lgps_err_t lgps_parse_blobmsg(struct blob_attr *msg, lgps_t *position);

#ifdef __cplusplus
}
#endif
