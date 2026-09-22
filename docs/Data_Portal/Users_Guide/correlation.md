# Correlation Plot

The Correlation Plot is a framework to correlate GDC molecular information (mutation, CNV, gene expression) with patient clinical and survival data.

## Launch Correlation Plot

At Analysis Center, select the "Correlation Plot" card.

[![ATF](images/correlation/1.png)](images/correlation/1.png "Click to see the full image.")

This displays an interface for generating correlation plots.

[![Intro](images/correlation/2.png)](images/correlation/2.png "Click to see the full image.")

In all illustrated examples, the cohort filter "Primary\_site IS Brain OR Breast" is used.

## General Access

Clicking the "Correlation Input" button will display the general access panel with three input choices to select data variables and launch the chart.
Only "Primary Variable" is required and the other two choices are optional. 

As a simple example, click the prompt button of Primary Variable to show the variable selection interface. From this interface, select "Disease type" variable, which will allow it to populate the Primary Variable, and activate the Submit button. Click the Submit button to launch a barchart showing a breakdown of disease type breakdown in the current cohort.

[![General](images/correlation/3.png)](images/correlation/3.png "Click to see the full image.")

The variable selection interface has toggling tabs on the left for choosing between variables of different modalities. This interface is shown for Primary Variable, Variable to Correlate, and Divide by Variable. This allows users to select any combination of clinical variables, survival, gene mutation, CNV, and expression into a plot to compare their correlation.

Using the same interface, select two variables to correlate their sample values. As an example, following selection of Disease Type as Primary Variable, click prompt button for Variable to Correlate. At the new panel, click the "Mutation/CNV" tab. At the gene search box, search for gene "IDH1". Submit to see a new barchart with IDH1 mutation status overlaid on disease types. Compared to the Disease type barchart in above example, this barchart has fewer number of cases, due to the use of gene mutation variable that excluded cases without DNA sequencing.

[![4](images/correlation/4.png)](images/correlation/4.png "Click to see the full image.")

## Mutation/CNV vs Disease Type

This quick access button compares mutation or CNV status of a gene with a clinical variable such as disease type. Click this button to open an input panel. To launch the plot using the default configuration, simply search for a gene. On finding a valid gene, a barchart opens showing disease breakdown from the current cohort.

[![5](images/correlation/5.png)](images/correlation/5.png "Click to see the full image.")

Correlation Plot allows grouping the disease types for correlation. To do so, at the input interface, click on Disease type button, select the Edit option. A new interface displays allowing to assign disease categories to groups. As example, drag Gliomas to the second group, and rename each group and click Apply button. This allows generating a barchart of two groups.

[![6](images/correlation/6.png)](images/correlation/6.png "Click to see the full image.")

To select a different clinical variable, at the input interface, click on the Disease type button, select the Replace option to find another variable.

To correlate gene CNV status with Disease type, at the input interface, before searching gene, select the CNV option. In this example, the barchart correlates EGFR gene CNV status with Disease type.

[![7](images/correlation/7.png)](images/correlation/7.png "Click to see the full image.")

To use gene set for mutation, at the input panel select "Gene Set". As an example, create a gene set with two genes EGFR and IDH1 that can generate a barchart overlaying a mutation variable that selects cases with mutation in either gene in the Mutated group (pink).
[![8](images/correlation/8.png)](images/correlation/8.png "Click to see the full image.")

## Mutation/CNV vs Survival

This quick access button compares gene mutation or CNV status with survival. At the input panel, searching for gene IDH1 will generate a Kaplan-Meier plot comparing survival between IDH1 mutated and wildtype groups. Gene CNV and gene set mutation can be applied the same way as Mutation/CNV vs Disease Type.
[![9](images/correlation/9.png)](images/correlation/9.png "Click to see the full image.")

## CNV vs Mutation

This compares CNVs and mutations for given genes. At the input panel, search for gene EGFR to launch a barchart showing EGFR mutation status as rows, and EGFR CNV status as overlays.
[![10](images/correlation/10.png)](images/correlation/10.png "Click to see the full image.")

This plot compares mutations and CNVs of two genes. At input panel, uncheck the checkbox for "Use Same Gene For CNV". Then enter two gene names at each search box and click Launch button to display a barchart comparing mutations and CNVs for two genes.
[![11](images/correlation/11.png)](images/correlation/11.png "Click to see the full image.")

## CNV vs Gene Expression

This compares a gene's CNV with its expression. At the input panel, enter gene EGFR to open a violin plot of EGFR gene expression, comparing across cases with different EGFR CNV status. As in other plots, CNV and expression of two different genes can be compared in this plot.
[![12](images/correlation/12.png)](images/correlation/12.png "Click to see the full image.")

## Gene Expression vs Survival

This compares gene expression level with survival. At the input panel, search for gene EGFR, it launches a Kaplan-Meier plot comparing survival between three groups of cases, with different EGFR expression level, or cases with missing gene expression data.
[![13](images/correlation/13.png)](images/correlation/13.png "Click to see the full image.")

A default FPKM-UQ cutoff (6.82) is applied to discretize EGFR expression. To customize the cutoff, click the burger menu button at the top left to access options to customize survival plot. Find the "EGFR uqFPKM" tag. Click and select Edit option to open the EGFR expression binning edit menu. At the text box, change the existing cutoff 6.82 to a new value and press ENTER. As example, two values 10 and 30 are entered, allowing samples to be divided into 3 bins based on their EGFR expression value: <=10, 10 to 30, \>30.
[![14](images/correlation/14.png)](images/correlation/14.png "Click to see the full image.")

## Plot-Specific Case Filters

You may create a plot-specific filter, applied on top of the app-wide cohort filter, to narrow down the cases that are included in the rendered visualization and/or computed analysis.

### Selecting Filter Variables and Values

#### 1. Initial variable and values selection
Click on the `+Add new filter` button in the plot's title bar. The familiar variable selection interface will show up, but after clicking on a variable, there will be an additional menu
to narrow down the categories or numeric values to include in the filter. After selecting values and clicking on the `Apply` button, the variable will be rendered in the plot title bar.

[![15](images/correlation/filter_variable_value_selection.png)](images/correlation/filter_variable_value_selection.png "Click to see the full image.")

#### 2. Edit a selected variable and values

You can click on a filter variable "pill" to open a menu to edit, negate, or remove the variable from the current filter.

[![16](images/correlation/filter_edit_menu.png)](images/correlation/filter_edit_menu.png "Click to see the full image.")


### Interactive Elements and Menus 

When mousing over near a rendered filter, the clickable elements other than the variable "pill" are highlighted. Navigation by tabbing will sequentially highlight these clickable
elements separately.

[![17](images/correlation/filter_clickable_highlight.png)](images/correlation/filter_clickable_highlight.png "Click to see the full image.")

Note that filter join-operators and group parenthesis are also clickable, to enable group-level edits. Mousing over a clickable element explains the expected behavior.

[![18](images/correlation/filter_clickable_highlight_2.png)](images/correlation/filter_clickable_highlight_2.png "Click to see the full image.")

Click on a parenthesis to see a menu of actions that could be applied to a filter group as a whole.

[![19](images/correlation/filter_group_paren_menu.png)](images/correlation/filter_group_paren_menu.png "Click to see the full image.")

Click on a join operator to see a menu of actions to edit a filter group, such as extending with new variables or transforming with nested levels.

[![20](images/correlation/filter_group_join_menu.png)](images/correlation/filter_group_join_menu.png "Click to see the full image.")


### A. Simple Filters

#### 1. Extend the top level filter with a new variable.

Click the *_rightmost_* `+AND` or `+OR` button.

[![21](images/correlation/filter_top_join.png)](images/correlation/filter_top_join.png "Click to see the full image.")

After selecting the filter variable and values and click on apply, a variable group will be created with two variables joined by the selected operator (`AND` or `OR`).

[![22](images/correlation/filter_top_join_2_var_group.png)](images/correlation/filter_top_join_2_var_group.png "Click to see the full image.")

#### 2. Extend a filter group by clicking on the operator label between the two variables - the same operator will be used.
<!-- AI: vertically align images to top  -->
[![23](images/correlation/filter_group_extend_menu.png)](images/correlation/filter_group_extend_menu.png "Click to see the full image.")
[![24](images/correlation/filter_group_extend_selection.png)](images/correlation/filter_group_selection.png "Click to see the full image.")


### B. Nested Filters

#### 1. You may group the current top level filter group by clicking on a righmost join operator button to the right.

The group will be enclosed in parenthesis to indicate that it will become nested once a new top variable is joined with an operator that doesn't match the nested group's operator.

[![23](images/correlation/filter_nested_selection.png)](images/correlation/filter_nested_selecteion.png "Click to see the full image.")

After selecting a new top level variable and values, the top level filter will be shown with a nested filter to the left.

[![24](images/correlation/filter_nested_top_level.png)](images/correlation/filter_nested_top_level.png "Click to see the full image.")
