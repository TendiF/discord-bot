const Discord = require('discord.js');
const Tatsu = require('tatsu');
require('dotenv').config({path: __dirname + '/.env'})

const {
  BOT_TOKEN,
  TATSU_TOKEN
} = process.env

const TatsuClient   = new Tatsu(TATSU_TOKEN);
const discordClient = new Discord.Client();

discordClient.login(BOT_TOKEN);

discordClient.on('ready', () => {
  console.log(`Logged in as ${discordClient.user.tag}!`);
});

discordClient.on('message', msg => {
  
  if (msg.content === 't!top10') {
    const embed = new Discord.MessageEmbed()
    // Set the title of the field
    .setTitle('A slick little embed')
    // Set the color of the embed
    .setColor(0xff0000)
    // Set the main content of the embed
    
    let rankNo = ''
    let score = ''
    let userTitle = ''
    TatsuClient.getGuildRankings('173184118492889089').then(async data => {
      let {rankings} = data
      let i = 0
      let tops10 = []
      for (const rank of rankings) {
        if (i === 10)break; 
        rank.user = await TatsuClient.getProfile(rank.user_id)
        tops10.push({...rank})
        rankNo += `\n ${rank.rank}`
        score += `\n ${rank.score}`
        userTitle += `\n ${rank.user.title ? rank.user.title : rank.user.username}`
        
        i++
      }
      embed.addFields(
        { name: 'Rank No.', value: rankNo, inline: true },
        { name: 'Score', value: score, inline: true },
        { name: 'User', value: userTitle, inline: true },
      )
  
      msg.channel.send(embed);
    })

    
  }
});
