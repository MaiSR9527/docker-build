#!/bin/bash

exec &>/usr/local/bin/set_welcome_message.log
set -x
# JINRISHICI API token
JINRISHICI_TOKEN="PCFIlf/WgXatH9QG/VWPQOdKzJgYpW1V"

# Get a random poem from JINRISHICI API
poem_info=$(/usr/bin/curl -s -H "X-User-Token: $JINRISHICI_TOKEN" 'https://v2.jinrishici.com/sentence' | /opt/homebrew/bin/jq -r '.data | "『\(.content)』——《\(.origin.title)》\(.origin.dynasty)·\(.origin.author)"' || echo "无法获取诗词内容")

# Get location and weather information
weather_info=$(/usr/bin/curl -s "https://v2.jinrishici.com/info" | /opt/homebrew/bin/jq -r '.data | "📌\(.region)，☁️天气\(.weatherData.weather) \(.weatherData.temperature)℃，🧭\(.weatherData.windDirection)\(.weatherData.windPower)级，💨风速\(.weatherData.visibility)/h"' || echo "无法获取天气信息")

# Get current date and hour
current_hour=$(date +"%_H" | tr -d ' ')

# Set greeting message based on current time
if [ ${current_hour} -ge 0 ] && [ ${current_hour} -lt 6 ] || [ ${current_hour} -eq 23 ]; then
    greeting="🌙 深夜了，早点睡觉哦~"
elif [ ${current_hour} -ge 6 ] && [ ${current_hour} -lt 12 ]; then
    greeting="🌤 早上好，新的一天开始了！"
elif [ ${current_hour} -ge 12 ] && [ ${current_hour} -lt 18 ]; then
    greeting="☀️ 中午好，休息一下吧~"
else
    greeting="🌛 晚上好，愿你有个好梦~"
fi

# Create login window text with the poem, author, and weather information
formatted_text="${greeting}\n${weather_info}\n${poem_info}"
echo ${formatted_text}

# Set login window text
defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "$formatted_text"

