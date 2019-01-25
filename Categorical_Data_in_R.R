library(openintro)
library(dplyr)
library(gapminder)
library(ggplot2)
library(forcats)
library(readr)
library(tidyr)
library(stringr)

gapminder <- gapminder::gapminder

gapminder %>% 
  distinct(country)

# Checking if variable is a factor
gapminder <- gapminder::gapminder


is.factor(gapminder$country)

# Convert factor columns to characters
gapminder <- gapminder %>% 
  mutate_if(is.factor, as.character)

# Convert characters columns to factors
(gapminder <- gapminder %>% 
    mutate_if(is.character, as.factor))

head(hsb2)

hsb2 %>% 
  count(read) %>% 
  View()
hsb2 <- hsb2 %>% 
  mutate(read_cat = ifelse(read < mean(hsb2$read), 
                           'below average', 'at or above average'))

head(hsb2)
hsb2 <- openintro::hsb2

hsb2 %>% 
  filter(between(read, 30, 76)) %>% 
  mutate(readers = case_when(
    between(read, 30, 40) ~ 'Not bad',
    between(read, 40, 50) ~ 'Good',
    between(read, 50, 60) ~ 'Very good',
    between(read, 60, 76) ~ 'Excellent'
  )) %>% 
  count(readers)

hsb2 %>% 
  mutate(readers = ifelse(read >= 30 & read < 40, 'Not bad',
                          ifelse(read >= 40 & read < 50, 'Good', 
                                 ifelse(read >= 50 & read < 60, 'Very good', 'Excellent'))))

hsb2 %>% 
  count(prog)

hsb2 %>% 
  mutate(academic = ifelse(prog == 'academic', 'yes', 'no')) %>% 
  head()


hsb2 %>% 
  filter(!is.na(prog)) %>% 
  mutate(frequency = if_else(prog %in% c('academic', 'general'), 1, 0)) %>% 
  group_by(race) %>% 
  summarise(percentage = mean(frequency))

(hsb2 <- hsb2 %>% 
    mutate(academic = case_when(
      prog == 'academic' ~ 'yes',
      prog != 'academic' ~ 'no'
    )))

(hsb2 <- hsb2 %>% 
    mutate(academic = case_when(
      prog == 'academic' ~ 'yes',
      prog == 'general' ~ 'not, but close',
      prog == 'vocational' ~ 'no'
    )))

head(hsb2)


(hsb2 <- hsb2 %>% 
    mutate(school = case_when(
      prog == 'academic' &  schtyp == 'public' ~ 'yes-pub',
      prog == 'general' &  schtyp == 'public' ~ 'general-pub'
    ))) %>% 
  pull(school) %>% 
  unique()


##### Forcats Functions #####
(multiple_choice <- read_csv('multipleChoiceResponses.csv'))
(multiple_choice <- multiple_choice %>% 
    mutate_if(is.character, as.factor))

multiple_choice %>% 
  pull(CurrentJobTitleSelect) %>% 
  levels()

multiple_choice <- multiple_choice %>% 
  mutate(grouped_titles = 
           fct_collapse(
             CurrentJobTitleSelect,
             "Computer Scientist" = c("Programmer", "Software Developer/Software Engineer"), 
             "Researcher" = "Scientist/Researcher", 
             "Data Analyst/Scientist/Engineer" = c("DBA/Database Engineer", "Data Scientist",
                                                   "Business Analyst", "Data Analyst", 
                                                   "Data Miner", "Predictive Modeler"))) 



multiple_choice <- multiple_choice %>% 
  mutate(grouped_titles = fct_other(grouped_titles,
                                    keep = c("Computer Scientist", 
                                             "Researcher", 
                                             "Data Analyst/Scientist/Engineer")))

multiple_choice %>% 
  mutate(grouped_titles = 
           fct_lump(CurrentJobTitleSelect,
                    n = 4,
                    other_level = "other titles")) %>%
  count(grouped_titles, sort = TRUE)

levels(multiple_choice$grouped_titles)

nlevels(gapminder$continent)
levels(gapminder$continent)

gapminder %>% 
  pull(continent) %>% 
  levels()

table(gapminder$continent)

gapminder %>% 
  summarise_if(is.factor, nlevels)

# Make a bar plot 
ggplot(gapminder, aes(x = continent)) +
  geom_bar() 


ggplot(gapminder, aes(fct_rev(fct_infreq(continent)))) +
  geom_bar() + 
  coord_flip()

# Make some NA values
gapminder[2,3] <- NA
gapminder[4,5] <- NA
sum(is.na(gapminder))

gapminder %>% 
  filter(!is.na(continent) & !is.na(lifeExp)) %>% 
  group_by(continent) %>% 
  summarise(mean_life = mean(lifeExp)) %>% 
  ggplot(aes(x = fct_reorder(continent, mean_life) , y = mean_life)) +
  geom_point() +
  coord_flip()

gapminder %>% 
  filter(!is.na(continent) & !is.na(lifeExp)) %>% 
  group_by(continent) %>% 
  summarise(mean_life = mean(lifeExp)) %>% 
  mutate(continent = fct_reorder(continent, mean_life)) %>% 
  ggplot(aes(x = continent, y = mean_life)) +
  geom_point() +
  coord_flip()

gapminder %>% 
  filter(!is.na(continent) & !is.na(lifeExp)) %>% 
  group_by(continent) %>% 
  summarise(mean_life = mean(lifeExp)) %>% 
  ggplot(aes(x = fct_reorder(continent, mean_life) , y = mean_life)) +
  geom_col() +
  coord_flip()

# Ordinal factors
names(hsb2)

# make wrong order
hsb2 <- hsb2 %>% 
  mutate(ses = fct_relevel(ses, "high", "low", "middle"))


hsb2 %>% 
  ggplot(aes(x = ses)) +
  geom_bar()

hsb2 %>% 
  ggplot(aes(x = fct_relevel(ses, "low", "middle", "high"))) +
  geom_bar() +
  labs(x = "ses")

# levels that are socyied becomes the first ones
hsb2 %>% 
  mutate(ses = fct_relevel(ses, "low")) %>% 
  pull(ses) %>% 
  levels()

# renaming factor levels
flying_etiquette <- read_csv('flying-etiquette.csv')

(flying_etiquette <- flying_etiquette %>% 
    mutate_if(is.character, as.factor))
flying_etiquette %>% 
  distinct(`who should get to use the two arm rests`)

# here we could use levels function
flying_etiquette %>% 
  pull(`who should get to use the two arm rests`) %>% 
  levels()

# or
levels(flying_etiquette$`who should get to use the two arm rests`)

# make the bar plot our of these
flying_etiquette %>% 
  ggplot(aes(x = fct_infreq(`who should get to use the two arm rests`))) +
  geom_bar() +
  labs(x = "Arm rest opinions")

flying_etiquette %>% 
  ggplot(aes(x = fct_infreq(`who should get to use the two arm rests`))) +
  geom_bar() +
  coord_flip() +
  labs(x = "Arm rest opinions")

# Another solution for labels on x-axis
flying_etiquette %>% 
  ggplot(aes(x = fct_infreq(`who should get to use the two arm rests`))) +
  geom_bar() +
  labs(x = "Arm rest opinions") +
  theme(axis.text.x = element_text(angle = 90))


flying_etiquette %>%
  mutate(`who should get to use the two arm rests` = fct_recode(
    `who should get to use the two arm rests`, 
    "Other" = "Other (please specify)",
    "Everyone should share" = "The arm rests should be shared",
    "Window people" = "The person by the window",
    "Aisle person" = "The person in aisle",
    "Fastest person" = "Whoever puts their arm on the arm rest first"
  )) %>% 
  count(`who should get to use the two arm rests`)

# typical analysis of factors 
dim(multiple_choice)

multiple_choice %>% 
  select(contains("LearningPlatformUsefulness")) %>% 
  gather(learning_platform, usefulness) %>% 
  filter(!is.na(usefulness)) %>% 
  mutate(learning_platform = str_replace(learning_platform, 
                                         "LearningPlatformUsefulness", "")) %>% 
  mutate(usefulness = if_else(usefulness == "Not Useful", 0, 1)) %>%
  group_by(learning_platform) %>% 
  summarize(avg_usefulness = mean(usefulness)) %>% 
  ggplot(aes(x = fct_rev(fct_reorder(learning_platform, avg_usefulness)), 
             y = avg_usefulness)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(x = "Learning Platform", y = "Percent finding at least somewhat useful") +
  scale_y_continuous(labels = scales::percent)


multiple_choice %>% 
  select(contains("LearningPlatformUsefulness")) %>% 
  gather(learning_platform, usefulness) %>% 
  filter(!is.na(usefulness)) %>% 
  mutate(learning_platform = str_replace(learning_platform, 
                                         "LearningPlatformUsefulness", "")) %>% 
  mutate(usefulness = if_else(usefulness == "Not Useful", 0, 1)) %>%
  group_by(learning_platform) %>% 
  summarize(avg_usefulness = mean(usefulness)) %>% 
  ggplot(aes(x = fct_reorder(learning_platform, avg_usefulness), 
             y = avg_usefulness)) +
  geom_col() +
  labs(title = "Usefulness of different learning platforms",
       subtitle = "Percentage of usefulness for 18 learning platforms",
       caption = "Source: Kaggle",         
       x = "",
       y = "") +
  coord_flip() +
  geom_text(aes(label = scales::percent(avg_usefulness),
                y = avg_usefulness + .12), 
            position = position_dodge(1.9),
            vjust = 0.4) +
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank())
