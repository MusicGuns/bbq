# (с) goodprogrammer.ru
#
# Контроллер, управляющий событиями
class EventsController < ApplicationController
  after_action :verify_policy_scoped, only: [:edit, :destroy, :update]
  after_action :verify_authorized, except: [:index, :password]
  # Встроенный в девайз фильтр - посылает незалогиненного пользователя
  before_action :authenticate_user!, except: [:show, :index, :password]

  # Задаем объект @event для экшена show
  before_action :set_event, only: [:show, :password]

  def index
    @events = Event.all
  end

  def show
    authorize @event
    # Болванка модели для формы добавления комментария
    @new_comment = @event.comments.build(params[:comment])

    # Болванка модели для формы подписки
    @new_subscription = @event.subscriptions.build(params[:subscription])

    # Болванка модели для формы добавления фотографии
    @new_photo = @event.photos.build(params[:photo])
  end

  def password
  end

  def new
    @event = Event.new
    authorize @event

    @event.user = current_user
  end

  def edit
    @event = policy_scope(Event).find(params[:id])
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    authorize @event

    @event.user = current_user

    if @event.save
      # Используем сообщение из файла локалей ru.yml
      # controllers -> events -> created
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  def update
    @event = policy_scope(Event).find(params[:id])
    authorize @event

    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit
    end
  end

  def destroy
    @event = policy_scope(Event).find(params[:id])
    authorize @event

    @event.destroy
    redirect_to events_url, notice: I18n.t('controllers.events.destroyed')
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description, :password)
  end

  def password_param
    params[:password]
  end
end
