# smmipsQC

Analysis of smMIP libraries

## Overview

## Dependencies

* [bwa 0.7.12](http://bio-bwa.sourceforge.net/)
* [python 3.6](https://www.python.org/downloads/)
* [smmips 1.0.9](https://pypi.org/project/smmips/)


## Usage

### Cromwell
```
java -jar cromwell.jar run smmipsQC.wdl --inputs inputs.json
```

### Inputs

#### Required workflow parameters:
Parameter|Value|Description
---|---|---
`fastq1`|File|Path to Fastq1
`fastq2`|File|Path to Fastq2
`panel`|String|Path to file with smMIP information
`smmipRegions`|String|Path to bed file with smmip regions
`outputFileNamePrefix`|String|Prefix used to name the output files
`reference`|String|Reference id, i.e. hg19 (Currently the only one supported)


#### Optional workflow parameters:
Parameter|Value|Default|Description
---|---|---|---
`outdir`|String|"./"|Path to directory where directory structure is created
`maxSubs`|Int|0|Maximum number of substitutions allowed in the probe sequence
`upstreamNucleotides`|Int|0|Maximum number of nucleotides upstream the UMI sequence
`umiLength`|Int|4|Length of the UMI
`match`|Int|2|Score of identical characters
`mismatch`|Int|-1|Score of non-identical characters
`gapOpening`|Float|-5|Score for opening a gap
`gapExtension`|Float|-1|Score for extending an open gap
`alignmentOverlapThreshold`|Int|60|Cut-off value for the length of the de-gapped overlap between read1 and read2
`matchesThreshold`|Float|0.7|Cut-off value for the number of matching pos
`remove`|Boolean|false|Remove intermediate files if True


#### Optional task parameters:
Parameter|Value|Default|Description
---|---|---|---
`align.memory`|Int|32|Memory allocated for this job
`align.timeout`|Int|36|Hours before task timeout
`align.bwa`|String|"$BWA_ROOT/bin/bwa"|Path to the bwa script
`align.modules`|String|"smmips/1.0.9 bwa/0.7.12 ~{refModule}"|Names and versions of modules to load
`regionsToArray.memory`|Int|1|Memory allocated for this job
`regionsToArray.timeout`|Int|1|Hours before task timeout
`assignSmmips.modules`|String|"smmips/1.0.9"|Names and versions of modules to load
`assignSmmips.memory`|Int|32|Memory allocated for this job
`assignSmmips.timeout`|Int|36|Hours before task timeout
`mergeExtraction.modules`|String|"smmips/1.0.9"|Names and versions of modules to load
`mergeExtraction.memory`|Int|32|Memory allocated for this job
`mergeExtraction.timeout`|Int|36|Hours before task timeout
`mergeCounts.modules`|String|"smmips/1.0.9"|Names and versions of modules to load
`mergeCounts.memory`|Int|32|Memory allocated for this job
`mergeCounts.timeout`|Int|36|Hours before task timeout


### Outputs

Output | Type | Description | Labels
---|---|---|---
`outputExtractionMetrics`|File|Metrics file with extracted read counts|vidarr_label: outputExtractionMetrics
`outputReadCounts`|File|Metric file with read counts for each smmip|vidarr_label: outputReadCounts


## Commands
This section lists command(s) run by smmipsQC workflow
 
* Running smmipsQC
 
### Assign
 
```
     set -euo pipefail
     smmips assign -b ~{sortedbam} -pa ~{panel} -pf ~{outputFileNamePrefix} -ms ~{maxSubs} -up ~{upstreamNucleotides} -umi ~{umiLength}  -m ~{match} -mm ~{mismatch} -go ~{gapOpening} -ge ~{gapExtension}  -ao ~{alignmentOverlapThreshold} -mt ~{matchesThreshold} -o ~{outdir} -r ~{region} ~{removeFlag}
```
 
### Align
 
```
     set -euo pipefail
     smmips align -bwa ~{bwa} -f1 ~{fastq1} -f2 ~{fastq2} -r ~{refFasta} -pf ~{outputFileNamePrefix} -o ~{outdir} ~{removeFlag}
```
 
### Merge
 
```
     set -euo pipefail
     smmips merge -pf ~{outputFileNamePrefix} -ft extraction -t ~{sep =" " extractionCounts}  ~{removeFlag}
```
 
### Merge
 
```
     set -euo pipefail
     smmips merge -pf ~{outputFileNamePrefix} -ft counts -t ~{sep =" " readCounts} ~{removeFlag}
```
 
### Post-process
 
```
     cat ~{regions} | sed 's/\t/./g'
```
## Support

For support, please file an issue on the [Github project](https://github.com/oicr-gsi) or send an email to gsi@oicr.on.ca .

_Generated with generate-markdown-readme (https://github.com/oicr-gsi/gsi-wdl-tools/)_
