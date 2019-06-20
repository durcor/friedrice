/*
 * ~/prg/slock/config.h
 * vi:ft=c
 */

/* user and group to drop privileges to */
static const char *user  = "ty";
static const char *group = "ty";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#0c090a",     /* after initialization */
	[INPUT] =  "#23191c",   /* during input */
	[FAILED] = "#9E8F73",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
