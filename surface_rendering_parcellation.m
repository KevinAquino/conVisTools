
% surface_rendering_parcellation.m
% 
%  Function here to generate a surface rendering of the aparc parcellation
% Assumes that you have 82 regions i.e. 34 Desikan killany regions Left: 7 Subcortical regions (from aparc) for each hemi
% 
% 2020
% Kevin Aquino <aquino.km@gmail.com>
% 
function surface_rendering_parcellation(surface_type,total_order,cmap_aparc)
	% Subjects directory
	subjects_directory=[getenv('SUBJECTS_DIR')];
	
	[verts,faces] = read_surf([subjects_directory,'/fsaverage/surf/lh.',surface_type]);
	surf_left.vertices=verts;
	surf_left.faces=faces+1;
	surf_left.EdgeColor='none';
	[verts,faces] = read_surf([subjects_directory,'/fsaverage/surf/rh.',surface_type]);
	surf_right.vertices=verts;
	surf_right.faces=faces+1;
	surf_right.EdgeColor='none';

% now display the results


% Now run the shading and load up the labels
v2=1:82;
v2(total_order) = 1:82;
label_struct=struct;
[~, label_struct.left_label, label_struct.left_ctab] = read_annotation([subjects_directory,'/fsaverage/label/lh.aparc.annot']);
[~, label_struct.right_label, label_struct.right_ctab] = read_annotation([subjects_directory,'/fsaverage/label/rh.aparc.annot']);


figure;
subplot(211)
[left_figh,right_figh1]=surface_display_results(label_struct,surf_left,surf_right,v2);
view([90 0])
colormap(cmap_aparc);caxis([0 82]);
set(left_figh,'visible','off');
right_figh2.FaceColor='flat';

subplot(212)
[left_figh,right_figh2]=surface_display_results(label_struct,surf_left,surf_right,v2);
view([-90 0])
colormap(cmap_aparc);caxis([0 82]);
set(left_figh,'visible','off')
right_figh2.FaceColor='flat';
camlight