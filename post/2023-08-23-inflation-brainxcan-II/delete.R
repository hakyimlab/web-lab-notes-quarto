varZdf %>%
  filter(nsam > 999) %>%
  ggplot(aes(x = Var1, y = (varZ - 1) / h2Y / nsam * msnp)) +
  geom_boxplot() +
  geom_hline(yintercept = 1, color = 'gray', linetype = 3) +
  labs(title = "(varZ - 1)*M/N/h2Y vs h2Y", x = "h2Y") 


varZdf %>%
  filter(nsam > 999) %>%
  ggplot(aes(x = prec, y = (varZ - 1) / h2Y / nsam * msnp)) +
  geom_point() + geom_smooth() +
  geom_hline(yintercept = 1, color = 'gray', linetype = 3) +
  labs(title = "(varZ - 1)*M/N/h2Y vs h2Y") 

for(nn in nsamlist)
{
  pp <- varZdf %>%
    filter(nsam == nn) %>%
    ggplot(aes(x = prec, y = (varZ - 1) / h2Y / nsam * msnp)) +
    geom_point() + geom_smooth() +
    geom_hline(yintercept = 1, color = 'green') +
    labs(title = glue("(varZ - 1)*M/N/h2Y vs h2Y - nsam={nn}" ) )+
    theme(legend.position = "none")
  print(pp)
}

varZdf %>% 
  filter(nsam >= 1000) %>% 
  mutate(phi=(varZ - 1)/h2Y/nsam*msnp ) %>% 
  group_by(h2Y,nsam,msnp) %>% 
  summarize(mean=mean(phi),sd=sd(phi),median=median(phi), .groups = "drop" ) %>% 
  ggplot(aes(h2Y, mean,col=as.factor(nsam))) + 
  geom_point() +
  labs(title = "mean (varZ - 1)*M/N/h2Y vs h2Y") 

varZdf %>% 
  filter(nsam >= 1000) %>% 
  mutate(phi=(varZ - 1)/h2Y/nsam*msnp ) %>% 
  group_by(h2Y,nsam,msnp) %>% 
  summarize(mean=mean(phi),sd=sd(phi),median=median(phi), .groups = "drop" ) %>% 
  ggplot(aes(nsam, mean,col=as.factor(msnp))) + 
  geom_point() +
  labs(title = "mean (varZ - 1)*M/N/h2Y vs nsam") 

varZdf %>% 
  filter(nsam >= 1000) %>% 
  mutate(phi=(varZ - 1)/h2Y/nsam*msnp ) %>% 
  group_by(h2Y,nsam,msnp) %>% 
  summarize(mean=mean(phi),sd=sd(phi),median=median(phi), .groups = "drop" ) %>% 
  ggplot(aes(msnp, mean,col=as.factor(nsam))) + 
  geom_point() +
  labs(title = "mean (varZ - 1)*M/N/h2Y vs msnp") 
