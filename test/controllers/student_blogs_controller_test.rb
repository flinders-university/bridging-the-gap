require 'test_helper'

class StudentBlogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student_blog = student_blogs(:one)
  end

  test "should get index" do
    get student_blogs_url
    assert_response :success
  end

  test "should get new" do
    get new_student_blog_url
    assert_response :success
  end

  test "should create student_blog" do
    assert_difference('StudentBlog.count') do
      post student_blogs_url, params: { student_blog: { body: @student_blog.body, finished: @student_blog.finished, slug: @student_blog.slug, title: @student_blog.title, user_id: @student_blog.user_id } }
    end

    assert_redirected_to student_blog_url(StudentBlog.last)
  end

  test "should show student_blog" do
    get student_blog_url(@student_blog)
    assert_response :success
  end

  test "should get edit" do
    get edit_student_blog_url(@student_blog)
    assert_response :success
  end

  test "should update student_blog" do
    patch student_blog_url(@student_blog), params: { student_blog: { body: @student_blog.body, finished: @student_blog.finished, slug: @student_blog.slug, title: @student_blog.title, user_id: @student_blog.user_id } }
    assert_redirected_to student_blog_url(@student_blog)
  end

  test "should destroy student_blog" do
    assert_difference('StudentBlog.count', -1) do
      delete student_blog_url(@student_blog)
    end

    assert_redirected_to student_blogs_url
  end
end
