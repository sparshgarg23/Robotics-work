# Robotics-work
This includes all robotics and Computer Vision assignments I have done uptil now.(All codes have been implemented from scratch without any external dependecy except basic I/O )
This repository includes
1) KLT tracking using Harris Corner(Self Implemented)
  harris.m->Computing harris corner
  extractBlockAlg.m->compute descriptor
  LucasKanade.m->Lucas Kanade trakcer
  KLT.m->for testing purpose
2)A Star self implemented
3)Image Stiching
  harris.m->Responsible for computing Harris Corner
  calculate_inliers.m->Responsible for computing projective transformations by using RANSAC
  dist2.m->Distance metric
  stiching_pair of images.m->Demonstrates results for stiching two images
  remove_border.m->utility function
 Results for corner,stiching and orderrandomstiching.jpg,inliersfoundransac.jpg,descriptor_hill.jpg
4)Mean Shift Segmentation and mean shift clustering
  RGB2LUV.m-transform image in RGB space to LUV space
  mean_shift algorithm1.m->demonstration of mean shift clustering
  sourcecode.m->runs mean_shift algorithm to perform mean shift segmentation on an image
  mainexecutable.m->RUns mean shift clustering
  findoptpeaks.m->used in mean shift clustering and segmentation
  pts.mat->used in mean shift clustering
  gaussian_kernel.m
  sunset.bmp,segmentedsunset with and without pixel,segmentedsunset clustered result.jpg results for mean shift segmentation
 5)Gaussian and Laplacian Pyramid
 gausspyramid.m
 
  
