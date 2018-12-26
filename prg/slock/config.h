/*
 * ~/prg/slock/config.h
 * vi:ft=c
 */

/* user and group to drop privileges to */
static const char *user  = "ty";
static const char *group = "ty";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#0E0F08",     /* after initialization */
	[INPUT] =  "#262915",   /* during input */
	[FAILED] = "#E49766",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
