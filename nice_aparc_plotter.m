% nice_aparc_plotter.m
% 
% Code here to make a nice aparc connectivity parcellation
% Assumes that you have 82 regions i.e. 34 Desikan killany regions Left: 7 Subcortical regions (from aparc) for each hemi
% 
% 2020
% Kevin Aquino <aquino.km@gmail.com>
% 

function [square_mat,inds,total_order,all_regions,cmap] = nice_aparc_plotter(img,cax,colLines)
% APARC parcellation
	% Here grab the names:
	% Freesurfer_directory
	freesurfer_subjects_folder=[getenv('SUBJECTS_DIR')];
	[~,~,ctab] = read_annotation([freesurfer_subjects_folder,'/fsaverage/label/lh.aparc.annot']);
	regions_hemi=ctab.struct_names(setdiff([1:36],[1 5]));
	% Ordering of the regions
	regions={'Frontal','Parietal','Temporal','Occpital','Cingulate','Insula'};

	names{1}={'superiorfrontal','rostralmiddlefrontal','caudalmiddlefrontal','parsopercularis','parstriangularis','parsorbitalis','lateralorbitofrontal','medialorbitofrontal','precentral','paracentral','frontalpole'};
	names{2}={'superiorparietal','inferiorparietal','supramarginal','postcentral','precuneus'};
	names{3}={'superiortemporal','middletemporal','inferiortemporal','bankssts','fusiform','transversetemporal','entorhinal','temporalpole','parahippocampal'};
	names{4}={'lateraloccipital','lingual','cuneus','pericalcarine'};
	names{5}={'rostralanteriorcingulate','caudalanteriorcingulate','posteriorcingulate','isthmuscingulate'};
	names{6}={'insula'};

	lh_inds=[];

	for nr=1:length(regions);
		for lb=1:length(names{nr})
			lh_inds = [lh_inds find(strcmp(regions_hemi,names{nr}{lb}))];
		end
		ind_line(nr)=length(lh_inds) + 0.5;
	end

	lh_inds = [lh_inds 35 36 37 38 39 40 41];
	ind_line(nr+1)=length(lh_inds) + 0.5;
	rh_inds = lh_inds+ 41;
	total_order=[lh_inds rh_inds];


	% Make the little colorbar
	square_mat=ones(41,5);
	set_cols=[[1;ind_line(1:end-1)'-0.5],ind_line'-0.5];
	for j=1:length(ind_line)
		square_mat(set_cols(j,1):set_cols(j,2),:) = j;
	end



	imagesc(img(total_order,total_order))
	hold on;
	for h=1:length(ind_line),
		line([ind_line(h) ind_line(h)], [0.5 82.5],'lineWidth',2,'Color',colLines);
		line([0.5 82.5],[ind_line(h) ind_line(h)],'lineWidth',2,'Color',colLines);

		line([ind_line(h)+41 ind_line(h)+41], [0.5 82.5],'lineWidth',2,'Color',colLines);
		line([0.5 82.5],[ind_line(h)+41 ind_line(h)+41],'lineWidth',2,'Color',colLines);
	end

	line([0.5 0.5], [0.5 82.5],'lineWidth',2,'Color',colLines);
	line([0.5 82.5],[0.5 0.5],'lineWidth',2,'Color',colLines);
	axis image;
	% colormap(cmap);
	caxis(cax);
	axis off;

	indicies=[0 ind_line-0.5];

	for j=1:(length(indicies)-1),
		inds{j,1} = indicies(j)+1:indicies(j+1);
		inds{j,2} = indicies(j)+1+41:indicies(j+1)+41;
	end

	all_regions = regions;
	all_regions{7} = 'subcortex';

	% Here is the colormap made for purposes of colouring the surface
	cmap = parcellation_colormap(inds);