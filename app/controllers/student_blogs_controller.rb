class StudentBlogsController < ApplicationController
  before_action :set_student_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /student_blogs
  # GET /student_blogs.json
  def index
    if current_user.group.level == 2
      @student_blogs = StudentBlog.where(user_id: current_user.id).order(:created_at)
    elsif current_user.group.level == 4
      @student_blogs = StudentBlog.all
    else
      @student_blogs = nil
    end
  end

  # GET /student_blogs/1
  # GET /student_blogs/1.json
  def show
    if @student_blog.finished == true
      if current_user.group.level == 2
        if @student_blog.user_id != current_user.id
          redirect_to student_blogs_path, notice: "Sorry, your colleague hasn't made that blog public yet."
        end
      elsif current_user.group.level == 4
      else
        redirect_to root_url, notice: "Sorry, your account does not have access to that feature."
      end
    end
  end

  # GET /student_blogs/report
  def report
    @student_blogs = StudentBlog.all
    render layout: false
  end

  # GET /student_blogs/new
  def new
    @student_blog = StudentBlog.new
  end

  # GET /student_blogs/1/edit
  def edit
    if @student_blog.finished == true
      if current_user.group.level == 2
        redirect_to student_blogs_path, notice: "Sorry, you marked that blog as finished. Please delete it and post it again."
      elsif current_user.group.level == 4

      else
        redirect_to root_url, notice: "Sorry, your account does not have access to that feature."
      end
    end
  end

  # POST /student_blogs
  # POST /student_blogs.json
  def create
    @student_blog = StudentBlog.new(student_blog_params)
    @student_blog.user = current_user
    @student_blog.slug = SecureRandom.uuid

    respond_to do |format|
      if @student_blog.save
        format.html { redirect_to @student_blog, notice: 'Student blog was successfully created.' }
        format.json { render :show, status: :created, location: @student_blog }
      else
        format.html { render :new }
        format.json { render json: @student_blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_blogs/1
  # PATCH/PUT /student_blogs/1.json
  def update
    respond_to do |format|
      if @student_blog.update(student_blog_params)
        format.html { redirect_to @student_blog, notice: 'Student blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @student_blog }
      else
        format.html { render :edit }
        format.json { render json: @student_blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_blogs/1
  # DELETE /student_blogs/1.json
  def destroy
    if current_user.group.level == 2
      if @student_blog.user_id != current_user.id
        redirect_to student_blogs_path, notice: "Sorry, your colleague hasn't made that blog public yet."
      end
    elsif current_user.group.level == 4
    else
      redirect_to root_url, notice: "Sorry, your account does not have access to that feature."
    end

    @student_blog.destroy
    respond_to do |format|
      format.html { redirect_to student_blogs_url, notice: 'Student blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_blog
      @student_blog = StudentBlog.find_by_slug(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_blog_params
      params.require(:student_blog).permit(:user_id, :title, :slug, :body, :finished)
    end
end
