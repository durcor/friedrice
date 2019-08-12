/* user and group to drop privileges to */
static const char *user  = "ty";
static const char *group = "ty";

static const char *colorname[NUMCOLS] = {
<<<<<<< HEAD
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
=======
	[INIT] =   "#1b180d",     /* after initialization */
	[INPUT] =  "#363019",   /* during input */
	[FAILED] = "#CCA86B",   /* wrong password */
>>>>>>> 22b8a96a31af2128246bf3757db83bd2409a5982
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;
