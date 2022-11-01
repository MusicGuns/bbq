# (с) goodprogrammer.ru
#
# Контроллер вложенного ресурса комментариев
class CommentsController < ApplicationController
  # задаем "родительский" event для коммента
  after_action :verify_authorized, only: %i[create destroy]
  before_action :set_event, only: %i[create destroy]

  # задаем сам коммент
  before_action :set_comment, only: [:destroy]

  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user

    authorize @new_comment

    if @new_comment.save
      # уведомляем всех подписчиков о новом комментарии
      EventMailJob.perform_async(@event.id, @new_comment.id, Comment)

      # если сохранился успешно, редирект на страницу самого события
      redirect_to @event, notice: I18n.t('controllers.comments.created')
    else
      # если ошибки — рендерим здесь же шаблон события
      render 'events/show', alert: I18n.t('controllers.comments.error')
    end
  end

  def destroy
    authorize @comment

    message = { notice: I18n.t('controllers.comments.destroyed') }

    if current_user_can_edit?(@comment)
      @comment.destroy!
    else
      message = { alert: I18n.t('controllers.comments.error') }
    end

    redirect_to @event, message
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_name)
  end
end
