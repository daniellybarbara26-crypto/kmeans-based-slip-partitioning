# kmeans-based-slip-partitioning
# K-means-Based Slip Segmentation for Induction Motors

This repository contains a MATLAB/Octave implementation of a methodology for segmenting induction motor rotor parameters into distinct slip regions based on their local behavior.

## 📌 Purpose

The goal of this code is to provide a systematic and reproducible approach for partitioning the slip domain into three regions (low, medium, and high slip). This segmentation is based on the local linear characteristics of rotor parameters and is intended to support the construction of piecewise affine models.

Importantly, this method **does not estimate the rotor parameters**. Instead, it operates on previously estimated parameter data and identifies regions where the parameter behavior can be approximated by distinct affine models.

---

## 📂 Input Data

The program requires a dataset containing rotor parameters as a function of slip. This dataset must be loaded from a file (e.g., `parametros.mat`) and should include:

- `s_hist`: vector of slip values  
- `x_hist(:,1)`: rotor resistance data  
- `x_hist(:,2)`: rotor reactance data  


---

## ⚙️ Method Overview

The segmentation procedure consists of the following steps:

### 1. Data Normalization
The selected parameter (rotor resistance or reactance) is normalized with respect to its maximum value to improve numerical stability.

### 2. Local Dataset Construction
For each slip value, a local dataset is constructed by selecting the nearest neighbors using a moving window approach. The window size is defined by a half-width parameter \( c \), resulting in \( 2c \) neighboring samples.

### 3. Local Affine Modeling
Within each local dataset, a first-order polynomial (affine model) is fitted using least squares:
\[
F_i(s) = A_i s + B_i
\]

This provides a local approximation of the parameter curve around each slip point.

### 4. Feature Extraction
Each local model is represented by its coefficients \((A_i, B_i)\), which form a feature vector describing the local behavior of the parameter.

### 5. K-means Clustering
The feature vectors are grouped into three clusters using the K-means algorithm. These clusters represent regions with similar local linear behavior.

### 6. Slip Domain Segmentation
Since each feature vector is associated with a specific slip value, the clustering results naturally define a partition of the slip domain into three regions.

---

## 🧠 Key Idea

Instead of clustering the parameter values directly, the method clusters **local linear models**. This allows the segmentation to capture changes in the behavior (slope and trend) of the parameter curves, leading to a more meaningful division of the slip domain.

---


## 🖥️ MATLAB / Octave Compatibility

- The code is compatible with both **MATLAB** and **GNU Octave**.
- When running in Octave, the following package must be loaded: pkg load statistics
