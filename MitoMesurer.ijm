#@ File (label = "Input directory", style = "directory") input
#@ String (label = "File suffix", value = ".vsi") suffix
#@ String (label= "Show images?", value = "yes") answer
#@ String (label= "Save?", value = "yes") answer_2
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
		run("Duplicate...", "duplicate channels=2");
		//run("Brightness/Contrast...");
		run("Enhance Contrast", "saturated=0.35");
		run("Subtract Background...", "rolling=50 slice");
		run("Median...", "radius=0.5");
		run("Measure");
		if (answer!="yes")
			close("*");
	}
if (answer_2=="yes")
	selectWindow("Results");
	saveAs("text", input+"_resultsMito_");
	selectWindow("Summary");
	saveAs("text", input+"_summaryMito_");
selectWindow("Summary");

