#OPPNI (Optimization of Preprocessing Pipelines for NeuroImaging) for fMRI analysis

This repository provides OPPNI (Optimization of Preprocessing Pipelines for NeuroImaging), which does fast optimization of preprocessing pipelines for BOLD fMRI (Blood Oxygenation Level Dependent functional MRI). OPPNI identifies the set of preprocessing steps (“pipeline”) specific to each dataset, which optimizes quality metrics of cross-validated Prediction and/or spatial-pattern Reproducibility for a range of analysis models (Strother et al., 2002, 2004; LaConte et al., 2003; Shaw et al., 2003). This procedure has been shown to significantly improve signal detection for individual scan sessions, overlap of brain activations for test-retest and group analysis, and sensitivity to brain-behaviour correlations (Churchill et al., 2012a, 2012b, 2015). The pipeline software can also be used for simple automated batch-processing of fMRI datasets, if no appropriate predictive analysis model is available to do optimization (e.g. some resting-state connectivity studies).
What can OPPNI do for you?
#Clean up your data:

It will automatically output time series data that has been optimally processed to control for noise and artifact (e.g. due to motion, physiology, scanner noise), which you can then use for further analysis. Automated de-noising is done based on replicable, statistical criteria; no more tedious batch scripting, or hand-selection of ICA components!
#Analyze your data:

As part of optimization, OPPNI creates Z-scored maps of brain activity for each dataset. You can directly report these results, or take individual activation maps and do group-level analysis. OPPNI can perform univariate predictive GLM (i.e., Gauss Naive Bayes) or multivariate predictive discriminant (i.e., regularised Canonical Variates Analysis) analysis of brain activity including standard, nonpredictive GLM (see manual for caveats). This can be done for a variety of different paradigm designs, including event-related and block-design tasks. Recent additions also include seed-based connectivity and component modelling, i.e., selecting an optimal PCA subspace.
Run batched pipelines:

If you cannot analyze your data (or OPPNI does not have the appropriate analysis tools), you can still preprocess your time series using OPPNI without doing optimization. Our scripts make it straightforward to choose the pipeline steps that you want, and perform automatic batch preprocessing of large datasets.
Implementation

Preprocessing and analysis scripts are coded in Matlab/Octave, and functions are called and managed using Python scripts. The code tests all possible combinations of a set of 12 different preprocessing steps, to identify the optimal pipeline for each fMRI dataset that is being tested. Current preprocessing options include AFNI utilities (Analysis of Functional NeuroImaging; Cox, 1996), along with a set of functions developed in-house. All steps are widely used in the fMRI literature, or demonstrated to be important in prior studies of pipeline optimization (e.g. Tegeler et al., 1999; La Conte et al., 2003; Shaw et al., 2003; Strother et al., 2004; Zhang et al., 2009; Churchill et al., 2012a, 2012b, 2015). Pipeline optimization is analysis-driven: it evaluates the quality of analysis results for each pipeline, via Prediction and Reproducibility metrics, and selects the pipeline that gives highest-quality outputs. Analysis techniques are “modular” – you choose the task design and analysis model you wish to optimize, from a list of available models. The pipeline software also includes a procedure for automated spatial normalization of subjects to an anatomical template, using FSL utilities. This enables users to run group-level analysis of preprocessed results across subjects and task runs.
#Acknowledgement

References

Churchill NW et al. (2012a): Optimizing Preprocessing and Analysis Pipelines for Single-Subject FMRI. I. Standard Temporal Motion and Physiological Noise Correction Methods. Human Brain Mapping 33:609–627

Churchill NW et al. (2012b): Optimizing Preprocessing and Analysis Pipelines for Single-Subject fMRI: 2. Interactions with ICA, PCA, Task Contrast and Inter-Subject Heterogeneity. PLoS One. 7(2):e31147

Churchill, N. W., R. Spring, B. Afshin-Pour, F. Dong and S. C. Strother (2015). "An Automated, Adaptive Framework for Optimizing Preprocessing Pipelines in Task-Based Functional MRI." PLoS One 10(7): e0131520.

Cox RW (1996): AFNI: Software for analysis and visualization of functional magnetic resonance neuroimages. Computers and Biomedical Research, an International Journal, 29(3): 162-173.

LaConte S et al. (2003): The Evaluation of Preprocessing Choices in Single-Subject BOLD fMRI Using NPAIRS Performance Metrics. NeuroImage, 18(1):10-27

Shaw ME et al. (2003): Evaluating subject specific preprocessing choices in multisubject fMRI data sets using data-driven performance metrics. NeuroImage. 19(3):988-1001.

Strother SC, Anderson J, Hansen LK, Kjems U, Kustra R et al. (2002): The Quantitative Evaluation of Functional Neuroimaging Experiments: The NPAIRS Data Analysis Framework. NeuroImage 15:747–771

Strother S et al. (2004): Optimizing the fMRI data-processing pipeline using prediction and reproducibility performance metrics: I. A preliminary group analysis. NeuroImage. 23:S196-S207.

Zhang J et al. (2009). Evaluation and optimization of fMRI single-subject processing pipelines with NPAIRS and second-level CVA. Magn. Reson. Imag. 27:264–278
