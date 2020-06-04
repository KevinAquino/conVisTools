% example_usage.m
% 
% Code here shows an example usage of the visualization tools currently works on mac and linux!
% 
% 2020
% Kevin Aquino <aquino.km@gmail.com>
% 
% MATLAB path from freesurfer (you dont need freesurfer installed just the folder)
freesurfer_matlab=['/Applications/freesurfer/matlab/'];

filExist=which('read_annotation');
% Here add path if you need to
if(~filExist)
	addpath(freesurfer_matlab);
end

% Again you dont need freesurfer installed just the subjects directory with fsaverage in it
subjects_directory='/Applications/freesurfer/subjects';

% Now you also need the surfaces so you need to specifity the subjects directory
if(~getenv('SUBJECTS_DIR'));
	setenv('SUBJECTS_DIR',subjects_directory);
end

% Now this is set up you can get started:
% Plot the connectivity parcellations:
figure('color','white');
linearVector = linspace(0,1,100).';reverseLinearVector = linearVector(end:-1:1);cmapA = [ones(size(linearVector)),reverseLinearVector,reverseLinearVector];cmapB = [linearVector,linearVector,ones(size(linearVector))];
cmap_fc = [cmapB;cmapA];

load('simulated_correlation.mat');
[square_mat,inds,total_order,all_regions,cmap] = nice_aparc_plotter(simulated_correlation,[-0.5 0.5],'black');
colormap(cmap_fc);
% Now plot the surface rendering
surface_type = 'inflated';
surface_rendering_parcellation(surface_type,total_order,cmap)

figure('color','white');
imagesc((1:83)')
colormap(cmap)
Centres(1)=1;
for j=1:7,	
	Centres(j+1) = mean(inds{j})+1;
end
set(gca,'YTick',Centres,'YTickLabel',['CorpusCallosum' all_regions],'XTick',[]);
