# MHX Legacy Code

This repository contains the remnants of nearly 15 years of development
work at the time of this writing, much of which began with Budway, then
SCMS, and today MHX. Though the repo contains a multitude of projects,
only the RFS Invoice Utility (and the RFS Operations Service built from
the same code) are still used.

# RFS Invoice Utility

The RFS Invoice Utility was originally intended as a quick hack of a tool
that was going to be replaced in a year, maybe two at the outside. As such,
it's practically an example of how *NOT* to write software, though to be
fair it has been updated and improved in the intervening decades.

# Development Standards

When you're working on the RFS Invoice Utility, there are some conventions
of which to be aware and some requirements to follow. They are:

* The "master" branch is where releases are taken. Only commit (or merge)
work to this branch that is tested and ready for release.

* Feel free to do your development work on any series of other branches, but
be sure to update the Versions.txt file with the changes, and increment the
version number in the about box accordingly, before merging into master.

* Resharper's default conventions have been adopted for naming standards and
code organization, though they weren't originally followed. As such, there
is a mix of styles. Just let Resharper do its thing, and we'll all be happy.

# Release Procedures

The following are the release procedures for the RFS Invoice Utility:

* Be sure that the Versions.txt file and the about box are updated, the 
former with the details of your changes and the latter with an incremented
version number.

* Make sure the release build you generate has the proper details in the
resulting App.config file. This is crucial to insure that invoices are 
saved to the right place, the correct database is used, and company filters
are applied properly.

* Produce a Zip archive of the resulting release build and hand off for
testing and distribution.

JBW, Monday, November 3, 2020, 12:44 hrs. 
