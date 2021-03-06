% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Global Fishing Watch functions.R,
%   R/get_cropped_fishing.R
\name{get_cropped_fishing}
\alias{get_cropped_fishing}
\title{Import Fishing Effort Within Specified Areas}
\usage{
get_cropped_fishing(file, box = c(-15, 3, 54, 64))

get_cropped_fishing(file, box = c(-15, 3, 54, 64))
}
\arguments{
\item{file}{The full name to a .csv file containing Global Fishing Watch data.}

\item{box}{A 4 number vector of min and max longitude, min and max latitude in that order. Defaults are set to slightly larger than the bounding box of `Scot_EEZ`.}

\item{area}{A Simple Feature object representing the areas to return fishing activity in.}
}
\value{
A dataframe of cells from a 0.01 degree grid which contains fishing activity,

A dataframe of cells from a 0.01 degree grid which contains fishing activity.
}
\description{
This function reads a csv file, when given a full path, and discards pixels which are outside Scottish waters.
}
\details{
For speed a rough crop is performed first, specified by `box`. Then a Simple Feature object containing polygons of Scottish Marine
Zones is used to perform a more expensive final crop. The SF object is hard coded into the function, but can be viewed by typing
`Scot_EEZ`.
}
