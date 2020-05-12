---
title: The Title
subtitle: 0.1.0
author: ["First Author1", "Second Author2"]
titlepage: true
toc-title: Table of Contents
logo: ../common/images/logo.pdf
listings-disable-line-numbers: true
footer-left: 'Highly Confidential: X and Y Staff Only'
!bash
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo "date: Build Date $(date --iso-8601=date)"
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---

# Changelog

<!-- Don't forget to adjust the version in the document subtitle -->

| Version | Date | Author | Changes |
| ------- | ---- | ------ | ------- |
| 0.1.0 | YYYY-MM-DD | you | Initial Revision |

!include(chapter1.md)

!include(chapter2.md)
