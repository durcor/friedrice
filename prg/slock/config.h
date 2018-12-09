/*
 * ~/prg/slock/config.h
 * vi:ft=c
 */

/* user and group to drop privileges to */
static const char *user  = "ty";
static const char *group = "ty";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#16191c",     /* after initialization */
	[INPUT] =  "#272c32",   /* during input */
	[FAILED] = "#F1992B",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
