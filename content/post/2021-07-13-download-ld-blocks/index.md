---
title: Download LD blocks
author: Festus Nyasimi
date: '2021-07-13'
slug: download-ld-blocks
categories:
  - how to
tags: []
---

This is a short tutorial on how to download ld block data as summarized by [Berisa and Pickrell](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4731402/). The LD data is available in hg19 genome build and for three different populations i.e. AFR, ASN and EUR.

First download the data from the [bit bucket repository](https://bitbucket.org/nygcresearch/ldetect-data/src/master/)

```
git clone https://bitbucket.org/nygcresearch/ldetect-data.git
```

If you need the LD blocks for use with data in a different genome build then you will need to do a liftover.

To demonstrate how to lift over the ld block co-ordinates from hg19 to hg18 we will use the EUR LD blocks

1.  Identify the data location

```
less ./EUR/fourier_ls-all.bed
```

2.  Using a custom script do the lift over

```
python liftover_blocks.py -input ./EUR/fourier_ls-all.bed -output hg38_fourier_ls-all.bed.gz
```

Check out for error messages in your liftover process

The `liftover_blocks.py` is a custom script that contains this info;

```         
#!/usr/bin/env python3

import gzip
import pyliftover

def _l(liftover, chr, pos):
    _new_chromosome = "NA"
    _new_position = "NA"
    try:
        pos = int(pos)
        l_ = liftover.convert_coordinate(chr, pos)
        if l_:
            if len(l_) > 1:
                print("Liftover with more than one candidate: %s", t.variant_id)
            _new_chromosome = l_[0][0]
            _new_position = int(l_[0][1])
    except:
        pass
    return _new_chromosome, _new_position

def run(args):
    print("starting lifting over.")
    liftover = pyliftover.LiftOver('hg19', 'hg38') # change genome builds here
    with gzip.open(args.output, "w") as _o:
        line = "{}\n".format("\t".join(["chr", "start", "stop"]))
        _o.write(line.encode())
        with open(args.input) as _i:
            for i,line in enumerate(_i):
                try:
                    comps = line.strip().split()
                    chrom = 'chr' + str(comps[0])
                    chrom = str(comps[0])
                    start = int(comps[1])
                    end = int(comps[2])

                    _chrs, _s = _l(liftover, chrom, start)
                    _chre, _e = _l(liftover, chrom, end)
                    if _chrs != _chre:
                        print("{}:{}:{} have different target chromosomes: {}/{}".format(chr, start, end, _chrs, _chre))
                    line = "{}\n".format("\t".join([_chrs, str(_s), str(_e)]))
                    _o.write(line.encode())
                except Exception as e:
                    print("Error for: %s", line)

    print("Finished lifting over.")

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser("Liftover ld regions file")
    parser.add_argument("-input", help="region file")
    parser.add_argument("-output", help="Where the output should go")
    args = parser.parse_args()

    run(args)
```
