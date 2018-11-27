/*
 * ~/prg/slock/config.h
 * vi:ft=c
 */

/* user and group to drop privileges to */
static const char *user  = "ty";
static const char *group = "ty";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#15140d",     /* after initialization */
	[INPUT] =  "#2e2b1c",   /* during input */
	[FAILED] = "#D69E58",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
