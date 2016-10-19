#!/bin/bash
cut -f1 BW_Multi.Mapped_atxr56_8C.filter.sam | sort | uniq -c > BW_Multi.Mapped_atxr56_8C.filter.count
