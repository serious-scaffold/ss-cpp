"""This is a nox file for automating things on we're cared about this project.


Session:
    session can be run with -s that you want.

    lint: lint local codebase and open the code-quality check locally that
        it will execute a check on codebase when having some operations on repos,
        such as commit, merge, push, and so on.

        Check code may fail because of the network.We can ignore the check with
        the option --no-verify, for example, git commit --no-verify -m 'feat: ....'.

        Usage: nox -s lint

    build: build a wheel for pip installation.

    tests: test the current codebase.

Example:
    This gives a example to lint the codebase locally::

        lint -s lint

Attributes:
    PRE_COMMIT_HOME (str): A tool called as pre-commit use a path to cache
        some repos from github or other binaries,it aims to help lint session.

        See https://github.com/pre-commit/pre-commit.git.

About nox, please see https://github.com/wntrblm/nox.git.
"""
import os
import sys

import nox

nox.needs_version = ">=2022.1.7"
nox.options.sessions = [
    "lint",
]

if os.environ.get("CI", None):
    nox.options.error_on_missing_interpreters = True


def get_home_dir():
    """get home dir base on the corresponding platform"""
    if sys.platform == "win32":
        homedir = os.environ["USERPROFILE"]
    elif sys.platform in ("linux", "darwin"):
        homedir = os.environ["HOME"]
    else:
        raise RuntimeError(f"Error! Not this system. {sys.platform}")
    return homedir


PRE_COMMIT_HOME = os.environ.get(
    "PRE_COMMIT_HOME",
    os.path.join(get_home_dir(), ".cache", "pre-commit"),
)


@nox.session
def lint(session: nox.Session) -> None:
    """
    Lint the codebase.
    """
    session.install("pre-commit")
    session.run("pre-commit", "install-hooks")
    session.log("install hooks successfully")
    session.run("pre-commit", "run", "-a")