function list=list_of_log_functions

list={ ...
1,6.1,'add_curve_type','Add type of curve to field "curve_types" of a well log';
1,6.5,'add_parameter','DEPRECATED: use "ds_add_parameter" instead';
0,6.1,'atca_histogram','Plot histograms of lithology-specific log curves (for ATCA)';
0,6.1,'atca_zoeppritz_plot','Plot angle-dependent reflection coefficients (for ATCA)';
1,6.5,'ds_add_parameter','Add a parameter to a dataset; create (appending to) field "parameter_info"';
1,6.5,'ds_unit_conversion','Convert curves from one system of units to another (e.g. ft ==> m)';
0,6.1,'l_4osiris','Create input data for Osiris';
0,6.1,'l_anisotropy4shale','Add anisotropy factors epsilon and delta to well logs';
1,6.1,'l_append','Append one log structure to another log structure';
1,6.1,'l_average','Compute a running average (mean) over one or more curves';
0,6.1,'l_avo_gradient','Compute AVO gradient (Aki && Richard)';
0,6.1,'l_backus_average','Compute curves with Backus average of velocities'; 
0,6.1,'l_iblock_log','Interactively block log curves';
1,6.1,'l_check','Check log structure for formal errors'
0,6.1,'l_check_vs_sonic','Plot check shot-derived velocity vs velocity from sonic log';
0,6.1,'l_checkshot','Apply check shot corrections to sonic log, compute depth-time relationship';
1,6.1,'l_combine','Combine two logs: the curves of the second log follow "below" the curves of the first';
0,6.1,'l_compaction_trend','Create log structure (velocity, density, porosity curves from compaction trend)';
1,6.1,'l_compare','Plot curves from one or more log structures, for comparison, onto one plot';
1,6.1,'l_convert','Convert matrix of curve values, curve names, etc. to log structure. Create log structure';
1,6.1,'l_crossplot','Make cross-plots of log curves';
1,6.1,'l_curve','Add/delete/replace curves of log data set; print one-line info about curves';
1,6.1,'l_curve_math','Add/replace curves of log structure by mathematical manipulation of existing curves';
1,6.1,'l_data','Create a synthetic log for algorithm testing and demo purposes';
1,6.1,'l_depth2index','Index vector prepended as a new depth column';
1,6.1,'l_depth2time','Compute one-way/two-way travel time from sonic or velocity log';
1,6.1,'l_depth2wb_depth','Change depth curve to depth below water bottom (subtract water depth and KB elevation)';
1,6.1,'l_elastic_impedance','Compute "elastic impedance" for user-defined angles of incidence';
1,6.1,'l_eqdepth','Resample log to equidistant/uniform depth samples';
1,6.1,'l_extend','Extend depth range of a log by prepending/appending null values';
1,6.1,'l_fill_gaps','Interpolate across null values (NaN''s) within specified curves';
1,6.1,'l_gc','Get values of a curve in a log structure';
1,6.1,'l_gd','Get description of a curve in a log structure';
1,6.1,'l_gu','Get units of measurement of a curve in a log structure';
2,6.1,'l_histoplot_1d','Compute/plot histogram of curve values';
0,6.1,'l_interp1','Use linear interpolation to create log curves at specified depth values';
1,6.1,'l_interpolate','OBSOLETE --- replaced by "l_fill_gaps"';
1,6.1,'l_itt2vel','Compute compressional or shear velocity from the interval transit time (sonic or shear-sonic)';
1,6.1,'l_litho_plot','OBSOLETE --- replaced by "l_lithoplot"';
1,6.1,'l_lithoplot','Plot log curves color-coded/symbol-coded by lithology';
1,6.1,'l_lithocurves','Compute logical curves representing lithology/rock-type';
0,6.1,'l_md2tvd','Convert sonic log from measured depth to true vertical depth';
1,6.1,'l_merge','Replace null values of one curve by corresponding values of another curve';
0,6.1,'l_mkzones','Break input log into pieces defined by depth ranges; output structure array (for ATCA)';
0,6.1,'l_pick_depths','Interactively pick depth values from plot of log curves';
1,6.1,'l_plot','Plot curves of log structure in form of separate subplots';
1,6.1,'l_plot1','Plot curves of log structures in one figure window';
0,6.1,'l_pore_pressure','Compute pore pressure (PP), frac gradient, overburden pressure; create log structure';
0,6.1,'l_pp4sand','Compute pore pressure (PP)in sand from PP in shale; add to log structure';
1,6.1,'l_principal_components','Compute principal-component representation of two or more curves';
0,6.1,'l_pwells2logs','Convert pseudo-well dataset to log structure vector';
1,6.1,'l_redefine','Redefine/change standard (default) curve mnemonics';
1,6.1,'l_reflection_coefficients','Compute reflection coefficients in time or depth';
1,6.1,'l_reflections','Compute reflection coefficients; requires curve "twt" (two-way time)';
1,6.1,'l_regression','Predict a log curve from one or more other log curves (regression, trend, fit)';
1,6.1,'l_rename','Rename (change names of) curve mnemonics';
1,6.1,'l_resample','Resample all curves of a log with given sample interval';
1,6.1,'l_rm_nulls','Remove null values (NaN) anywhere or at the top and the bottom of a log';
0,6.1,'l_sand_shale_histogram_plot3','Create figure with histogram plots of 3 curves for sand/shale';
0,6.1,'l_sand_shale_histogram_plot4','Create figure with histogram plots of 4 curves for sand/shale';
1,6.1,'l_seismic_acoustic','Compute seismic-relevant curves such as P-velocity and acoustic impedance';
1,6.1,'l_seismic_elastic','Compute P-velocity, acoustic impedance, S-velocity, Poisson''s ratio';
1,6.1,'l_select','Select subset of log curve(s) from log structure';
1,6.1,'l_sonic2time','DEPRECATED: Use "l_depth2time" instead';
1,6.1,'l_sort','Sort curves of a log so that values of a specified curve increases monotonically';
1,7.0,'l_subtract_ekb','Subtract the Kelly bushing elevation from the depth curve';
1,6.1,'l_switch_depth','Replace "depth" column (1st column) of log structure with another column';
0,6.1,'l_table2log','Convert table to log structure';
0,6.1,'l_time2depth','Compute depth curve from time curve using either a sonic or velocity curve';
1,6.1,'l_tools','Show available log-related tools';
1,6.1,'l_trend_removal','Remove linear trend from log curve';
0,6.1,'l_trend_estimation_and_removal','Estimate general trend of a curve and remove it';
0,6.1,'l_trend_estimation_and_removal1','Estimate linear/log-linear trend of a curve and remove it';
0,6.1,'l_trend_correction','Correct log curve so that the values reflect a different depth';
1,6.1,'l_unit_conversion','DEPRECATED; replace by "ds_unit_conversion"';
0,6.1,'l_utils','Show useful, log-related  utilities';
0,6.1,'l_vclay2sbrine','Compute brine (water) saturation from clay volume log for fluid substitution';
0,6.1,'li_elastic_impedance','Compute "elastic impedance" with interactively selected parameters';
0,6.1,'li_select','Interactively select curves of well log or edit curve info';
1,7.1,'read_las_file','Read well log from disk file in LAS 2.0 or LAS 3.0 format';
1,6.1,'read_las2_file','Read well log from disk file in LAS 2.0 format';
1,7.1,'show_las_header','Output/display header of LAS 2.0 file';
1,6.1,'write_las_file','Write log to disk file in LAS 2.0 format';
};
