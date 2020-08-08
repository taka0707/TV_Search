class TvSchedulesController < ApplicationController
  require "nokogiri"
  require 'chronic'

  def index
    agent = Mechanize.new
    page = agent.get("https://tv.yahoo.co.jp/listings/realtime/")
    form = page.forms[0]
    form.q = '心霊'
    page = agent.submit(form)
    
    date_docs = page.css(".leftarea > p > em")
    title_docs = page.css(".rightarea > .yjLS > a")
    channel_docs = page.css(".rightarea > p > .pr35")
    DateTimeEdit(date_docs)
    TitleEdit(title_docs)
    ChannelEdit(channel_docs)
    @tvs = []
    @dates.zip(@titles, @channels) do |date, title, channel|
      @tv = TvSchedule.new
      @tv.start_time = date
      @tv.title = title
      @tv.channel = channel
      @tv.user_id = current_user.id
      @tvs << @tv
      # binding.pry
    end
  end

  def DateTimeEdit(date_docs)
    @docs = date_docs.each_slice(2).to_a
    @dates = []
    @docs.each do |doc|
      date = doc.join(" ")
      date.slice!(/～(.+)/)
      @dates << Chronic.parse(date).to_s(:datetime)
    end
  end

  def TitleEdit(title_docs)
    @titles = []
    title_docs.each do |doc2|
      @titles << doc2.text
    end
  end

  def ChannelEdit(channel_docs)
    @channels = []
    channel_docs.each do |doc3|
      @channels << doc3.text unless doc3.values.include?("pr35 floatl")
    end
  end
end
