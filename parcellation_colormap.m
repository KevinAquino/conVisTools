% parcellation_colormap.m
% 
% Code here to make a nice aparc colormap that can be used for a number of things
% Assumes that you have 82 regions i.e. 34 Desikan killany regions Left: 7 Subcortical regions (from aparc) for each hemi
% 
% 2020
% Kevin Aquino <aquino.km@gmail.com>
% 

function cmap_aparc = parcellation_colormap(inds)
	% Function currently for aparc but couldi be made more general

	% Major Region colors:
	% Frontal
	cols{1}=[0.803922,0.243137,0.313725];
	% Parietal
	cols{2}=[0.274510,0.509804,0.701961];
	% Temporal
	cols{3}=[0.862745,0.972549,0.647059];
	% Occiptal
	cols{4}=[0.470588,0.070588,0.513725];
	% Cingulate
	cols{5}=[0.000000,0.462745,0.050980];	
	% Insula
	cols{6}=[0.901961,0.580392,0.137255];
	% Subcortex
	cols{7}=[0.768627,0.227451,0.984314];

	cmap_aparc = zeros(82,3);
	ii=1;
	for nr=1:7,
		n_tot=length(inds{nr,1});
		% Factors here performs a gradation of each region
		% hard coded to change the color from being 60% of the intensity to 100% 
		% over n_tot (number of regions) in each major region
		factors=linspace(0.6,1,n_tot);
		for ind_r=1:n_tot
			cmap_aparc(ii,:) = factors(ind_r)*cols{nr};
			ii = ii+1;
		end

	end

	cmap_aparc(42:end,:) = cmap_aparc(1:41,:);

	cmap_aparc = [0.75 0.75 0.75 ;cmap_aparc];