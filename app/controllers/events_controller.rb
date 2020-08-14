class EventsController < ApplicationController
  before_action :set_time_zone, only: :DateTimeEdit
  before_action :authenticate_user!, only: [:new, :search, :edit]
  before_action :set_event, only: [:edit, :update, :destroy]
  require "nokogiri"
  require 'chronic'

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to root_path
    else
      flash.now[:alert] = '保存が出来ませんでした。'
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to root_path
    else
      flash.now[:alert] = '更新が出来ませんでした。'
      render :edit
    end
  end

  def destroy
    if @event.destroy
      redirect_to root_path, notice: 'イベントを削除しました。'
    else
      flash.now[:alert] = '削除が出来ませんでした。'
      render :edit
    end
  end

  def search
    @tvs = []
    events = Event.all
    events.each do |event|
      @tvs << event
    end
    word = tv_schedule_params[:keyword]
    if word.present?
      agent = Mechanize.new
      page = agent.get("https://tv.yahoo.co.jp/listings/realtime/")
      form = page.forms[0]
      form.q = word
      page = agent.submit(form)
      date_docs = page.css(".leftarea > p > em")
      if date_docs.present?
        title_docs = page.css(".rightarea > .yjLS > a")
        channel_docs = page.css(".rightarea > p > .pr35")
        DateTimeEdit(date_docs)
        TitleEdit(title_docs)
        ChannelEdit(channel_docs)
        @dates.zip(@titles, @channels) do |date, title, channel|
          @tv = Event.new
          @tv.start_time = date
          @tv.title = title
          @tv.memo = channel
          @tvs << @tv
        end
        @tvs.sort_by { |a| a[:start_time] }
      else
        flash.now[:alert] = '検索結果はありませんでした。'
        render :index
      end
    else
      flash.now[:alert] = '文字を入力して下さい。'
        render :index
    end
  end

  def DateTimeEdit(date_docs)
    @docs = date_docs.each_slice(2).to_a
    @dates = []
    @docs.each do |doc|
      date = doc.join(" ")
      date.slice!(/～(.+)/)
      @dates << Chronic.parse(date, :now => Time.local(Time.current.year)).to_s(:datetime)
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

  def set_time_zone
    Chronic.time_class = Time.zone
  end

  private

  def tv_schedule_params
    params.permit(:keyword)
  end

  def event_params
    params.require(:event).permit(:title, :start_time, :memo).merge(user_id: current_user.id)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
