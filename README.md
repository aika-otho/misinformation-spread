# misinformation-spread

The context of our model is the spread of novel misinformation on social media and how well-informed and misinformed users spread their information to convince other users. Using a top-down approach, the exploratory-driven model recreates the social media environment as a network. 

Fig. 1.
![Screenshot (780)](https://github.com/aika-otho/misinformation-spread/assets/115614862/8d5bc314-93e5-48cb-b832-aaba58f11f78)

As can be seen in Fig. 1, the well-informed nodes (green) are located in the upper right quadrant, the misinformed nodes (red) are located in the lower left quadrant, and the undecided gray nodes (neither well-informed nor misinformed) are randomly distributed on all quadrants. Nota bene, the words “node”, “user”, and “agent” will be used interchangeably.

Fig. 2.
![Screenshot (781)](https://github.com/aika-otho/misinformation-spread/assets/115614862/dea661d6-4c0b-4fbb-bcd2-2b09f773dad7)

Position-wise, we believe this gives a fair chance for both well-informed and misinformed agents. It should be mentioned that the node conglomerates (Fig. 2) distributed randomly throughout the space represent different communities (for instance, Subreddits or Telegram groups) that are inevitably found throughout social media. In this case, these communities act as hubs of information.

All agents perform the same fundamental actions in the same order; receive information, calculate the probability of conviction, become convinced or not, and share the information; all of these actions happen per node and in parallel; agents are asynchronously updated. Owing to the actions agents perform, we consider the type of agent cognition as reflexive. Due to low computational power, the number of ticks had to be limited to 1000 (in BehaviorSpace, not in the actual model) to collect data for statistical analysis.

The probabilities are calculated based on the agent property and parameter Phone Use, varying in each node. We decided to have phone use determine the probability of conviction based on the work of Coninck et al. (2021) and Enders et al. (2021). The former concludes that there is an association between exposure to personal contacts and digital media with misinformation beliefs. In a similar light, the latter concludes that those who use social media more frequently tend to share more misinformation. We believe that this provides good support for our assumption.

Phone Use is determined using the data from  Bányai et al. (2017), stating that, on average, users spend approximately 23 hours per week on social media, which comes to an average of 3.5 hours per day (numbers are rounded). The data were then implemented as a random distribution. In our model, we set the minimum limit to 0 hours, equating to a 0% probability of being misinformed, and the maximum to 6.9 hours, equating to a 98.5% probability. 

Fig. 3. 
![Screenshot (782)](https://github.com/aika-otho/misinformation-spread/assets/115614862/3be7193a-43b1-4367-bce0-7050d37b6a25)

There are four measures; a plot, a percentage of misinformed and well-informed users, and a ratio of links between them (Fig. 3). The plot provides a more visual but also quantitative view of the model (it is harder than expected to quantify how many misinformed nodes there are just by viewing the network), the ratio is used to complement the plot to observe what would be the certain threshold where misinformation would reach variance stability, (or where it would inevitably spread to all users), and the percentages give tangible numeric quantities that can, later on, be converted into the number of misinformed agents and be used for statistical analysis.

The model possesses three sliders, namely number-of-nodes (ranging from 180 to 350), connections-per-node (from 3 to 10), and misinformation-bias (from 0 to 30). Since the first two parameters are self-explanatory, we will only describe the third.

In numbers, when the misinformation-bias is set to 30%, and a user with a 25% probability of being misinformed is misinformed, the users probability increases by 30%. The user then has a 32.5% probability of staying misinformed. There is a limit of 100% to percentage probability for cases where the addition should equal a percentage higher than 100%. Thus, the bias makes it harder for a misinformed user to be well-informed. We agree that it is a realistic implementation of what is explained in the Problem statement. The reason we decided to put this as a slider is that there are no quantitative data specifying the extent to which this bias occurs. In light of the two previous research papers, we think the parameter misinformation bias is well supported. 

## Sources:
Bányai, F., Zsila, A., Királu, O., Maraz, A., Elekes, Z., Griffiths, M. D., Andreassen, C. S., & Demetrovics, Z. (2017). Problematic Social Media Use: Results from a Large-Scale Nationally Representative Adolescent Sample. PLoS ONE, 12(1): e0169839. doi:10.1371/journal.pone.0169839

De Coninck, D., Frissen, T., Matthijs, K., d'Haenens, L., Lits, G., Champagne-Poirer, O., Carignan, M., David, M. D., Pignard-Cheynel, N., Salerno, S., & Généreux, M. (2021). Beliefs in Conspiracy Theories and Misinformation About COVID-19: Comparative Perspectives on the Role of Anxiety, Depression and Exposure to and Trust in Information Sources. Frontiers in Psychology, 12. doi:10.3389/fpsyg.2021.646394

Del Vicario, M., Bessi, A., Zollo, F., Petroni, F., Scala, A., Caldarelli, G., Stanley, H. E., & Quattrociocchi, W. (2015). The spreading of misinformation online. Proceedings of the National Academy of Sciences of the United States of America, 113(3), 554-559. doi:10.1073/pnas.1517441113

Enders, A.M., Uscinski, J.E., Seelig, M.I., Klofstad, C. A., Wuchty, S., Funchion, J. R., Murthi, M. N., Premaratne, K., & Stoler, J. (2021). The Relationship Between Social Media Use and Beliefs in Conspiracy Theories and Misinformation. Polit Behav. doi:10.1007/s11109-021-09734-6

Southwell, B. G., & Thorson, E. A. (2015). The Prevalence, Consequence, and Remedy of Misinformation in Mass Media Systems. Journal of Communication, 65(4), 589-585. doi:10.1111/jcom.12168

Swire-Thompson, B., Ecker, U.K.H., Lewandowsky, S. and Berinsky, A.J. (2020), They Might Be a Liar But They’re My Liar: Source Evaluation and the Prevalence of Misinformation. Political Psychology, 41: 21-34. doi:10.1111/pops.1258

Turel, O., & Osatuyi, B. (2021) Biased Credibility and Sharing of Fake News on Social Media: Considering Peer Context and Self-Objectivity State, Journal of Management Information Systems, 38(4), 931-958. doi:10.1080/07421222.2021.199061

