# DSTAF (Data Sharing Technology Assessment Framework)

DSTAF (Data Sharing Technology Assessment Framework) is an R Shiny app developed to support stakeholders in their evaluation of technologies and approaches that advance their data-sharing initiatives, whether they are interested in technologies for external data sharing or support an organization's internal data reuse.

The framework is designed to assist stakeholders in determining the requirements and use cases important to their organization. The resulting assessment scores can be used to compare how well different technology approaches or project scopes meet organizational objectives.

# Acknowledgements

This framework came together thanks to the efforts of the Clinical Research Data Sharing Alliance ([CRDSA](https://crdsalliance.org/resources/#tiwg)) Technology and Innovation Work Group: Peter Mesenbrink (Work Group Chair, Novartis), Dave Alonso (The Michael J. Fox Foundation), Alain Njimoluh Anyouzoa (Takeda), Luk Arbuckle (Privacy Analytics), Debbie Bucci (Equideum Health), Srikanth Emmadi (GSK), Cathal Gallagher (D-Wise), Matt Harvey (AstraZeneca), Aaron Mann (CRDSA), Lucy Mosquera (Replica Analytics), Neil Postlethwaite (Health Data Research UK), Mai Tran (Roche), Ramona Walls (Critical Path Institute), Matthew Wien (Takeda), Julie Wood (Vivli), Shaoming Yin (Takeda).

## How to

DSTAF App allows you to assess your technology in an interactive and visual way. The app is divided in two parts: **Assessment** and **Summary**.

1.  **Assessment**

You can complete these two steps in the order that you find more convenient.

-   In the Met column, select whether or not the requirement was met by the technology that is being evaluated. You do not need to fill in all the requirements, some of them might not apply, so they can be left blank.

-   Determine which requirements are applicable to each of the use cases using the check-boxes. You can use the filtering on the left of the table to help yourself find the information that you are looking for.

Once you have completed the assessment table, you can click the button Summary.

2.  **Summary**

In this part, you will be able to find the results and evaluation of your technology or data-sharing initiative.

Again, the filtering on the left will help you find what you are looking for.

3.  **Save your data**

If you want to save your information, you can download both tables, Assessment and Summary, in excel format. Just be careful because they will be saved as they are, so be sure you are showing on the tables the view of your interest.

## Dependencies

Project dependencies are managed by the {renv} package. Run `renv::restore()` to download the requisite packages for this project.
