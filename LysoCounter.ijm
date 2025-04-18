#@ File (label = "Input directory", style = "directory") input
#@ String (label = "File suffix", value = ".vsi") suffix
#@ String (label= "Show images?", value = "yes") answer
#@ String (label= "Save?", value = "no") answer_2
#@ String (label= "Clear?", value = "yes") answer_3
if (answer_3=="yes")
	close("*");
list=getFileList(input);
N=0;
for (i=0;i<list.length;i++){
	if (endsWith(list[i], suffix))
		N=N+1;
	}
for (i=0;i<N;i++){
	if (endsWith(list[i], suffix))
		open(list[i]);
		close;
		close;
		run("Duplicate...", "duplicate channels=1");
		//run("Brightness/Contrast...");
		run("Enhance Contrast", "saturated=0.35");
		run("Subtract Background...", "rolling=30 slice");
		run("Median...", "radius=0.5");
		setAutoThreshold("Otsu dark no-reset");
		setOption("BlackBackground", true);
		//Make sure to check with a raw image if you agree with the mask
		run("Convert to Mask", "method=Otsu background=Dark only black");
		run("Watershed");
		run("Analyze Particles...", "size=0.5-Infinity display exclude summarize overlay composite");
		if (answer!="yes")
			close("*");
}
if (answer_2=="yes")
	selectWindow("Results");
	saveAs("text", input+"_results_");
	selectWindow("Summary");
	saveAs("text", input+"_summary_");
selectWindow("Summary");
