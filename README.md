# route53.mak

## Prerequisites

* [cli53](https://github.com/barnybug/cli53)
* AWS credentials in [`~/.aws/credentials`](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
* GNU make
* Git (optional)
* Perl (optional, for the commit message hook)

## Setting up the Git repository

Create a `Makefile` that includes the `route53.mak` file:

```make
include /path/to/route53.mak
```

If you want to use a non-default AWS credential profile, set the `PROFILE` variable in `Makefile`, like this:

```make
include /path/to/route53.mak
PROFILE = myprofilename
```

Create a `.gitignore` file to ignore the `.route53` directory:

```
/.route53
```
## Adding a zone file

Run `make ZONENAME`

For example: `make example.com`

This will create a hosted zone in your AWS account for `example.com` if one doesn't already exist, and then export the zone file to a file named `example.com` in the current directory. The zone file will contain the NS records for the zone.

## Updating your zones

After editing your zone files, run: `make -j`

This will upload your changes to Route 53 and wait for them to be published.

## Git commit message hook

Copy or symlink `prepare-commit-msg` to the `.git/hooks` directory and your commit
messages will be automatically prepended with the name(s) of the changed
zone(s), like this:

```
[example.com] Update MX record
```

```
[example.com, example.net] Update CAA records
```
