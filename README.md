# MIMOcepstrum
Code for numerical illustrations accompanying the paper A MIMO Cepstrum.
## Summary
The code in this repository represents a minimal working example in Matlab for the simulations in the manuscript "A Multiple-Input Multiple-Output Cepstrum", a preprint of which can be found on [arXiv](https://arxiv.org/abs/1803.03080), by Oliver Lauwers, Oscar Mauricio Agudelo and Bart De Moor, which deals with the question of extending the notion of power cepstrum to the MIMO case. This manuscript has been sent in to be considered for publication to the IEEE Control Systems letters (in affiliation with the 2017 IEEE Conference on Decision and Control).

Two numerical examples are available:
 - A numerical illustration, consisting of a synthetic model that is fully known and can be handled both computationally and theoretically.
 - A case study on a non-isothermal continuous stirring tank reactor, suffering from linear fouling. The original simulink diagram generating the data has been added, but can only be run with Matlab version 2017b or newer. The data used in the paper is added as .mat-file, and can be handled by earlier versions of Matlab.

Bear in mind that this code is not meant as a fully working software package, but serves merely as an illustration accompanying the manuscript mentioned earlier.

## Reference
When using this code or discussing results of the extended cepstral distance measure, please refer to [this paper](https://arxiv.org/abs/1803.03080).
