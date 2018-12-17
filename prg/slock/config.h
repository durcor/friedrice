/*
 * ~/prg/slock/config.h
 * vi:ft=c
 */

/* user and group to drop privileges to */
static const char *user  = "ty";
static const char *group = "ty";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#0A1815",     /* after initialization */
	[INPUT] =  "#15342d",   /* during input */
	[FAILED] = "#E4A550",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
