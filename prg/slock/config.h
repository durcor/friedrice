/*
 * ~/prg/slock/config.h
 * vi:ft=c
 */

/* user and group to drop privileges to */
static const char *user  = "ty";
static const char *group = "ty";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#0D0E12",     /* after initialization */
	[INPUT] =  "#1d1f29",   /* during input */
	[FAILED] = "#C6B8A8",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
