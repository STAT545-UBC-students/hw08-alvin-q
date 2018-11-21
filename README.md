# hw08-alvin-q

This homework repo contains a Shiny app for `gapminder`. The file is here:

- [Alvin's Gapminder Shiny App](https://github.com/STAT545-UBC-students/hw08-alvin-q/blob/master/gapminder_alvin/app.R)

The actual shiny app is also deployed at:  [https://alvin-q.shinyapps.io/gapminder_alvin/](https://alvin-q.shinyapps.io/gapminder_alvin/)

For this homework assignment, I've created a new shiny app for the gapminder dataset. This app essentially let's a user visualize the distribution of GDP Per Capita for each country across the different continents.

I've incorporated a number of different features:

- There is a slider bar that lets the user define the range of GDP per capita to filter for in both the plots and table.

- There is are check boxes that let the user pick which continents to filter for both the plots and the table.

- There are radio buttons that let the user choose what type of plot to display. The options are violin, jitter or both.

- The theme is altered from the default. The `flatly` theme is used using `theme = shinytheme("flatly")`.

- There are check boxes that let the user pick which columns from the gapminder dataset are used to be displayed in the table.

- The table is displayed as a `datatable`. So it becomes interactive.