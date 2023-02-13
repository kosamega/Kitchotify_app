require 'test_helper'

class IntroQuizTest < ActiveSupport::TestCase
  def setup
    @intro_quiz = intro_quizzes(:intro_quiz1)
  end

  test 'クイズが有効' do
    assert @intro_quiz.valid?
  end

  test '名前が空でない' do
    @intro_quiz.name = nil
    assert_not @intro_quiz.valid?
  end

  test '名前が一意' do
    duplicate_intro_quiz = @intro_quiz.dup
    assert_not duplicate_intro_quiz.valid?
  end

  test '範囲が空でない' do
    @intro_quiz.range = nil
    assert_not @intro_quiz.valid?
  end

  test '問題数が空でない' do
    @intro_quiz.q_num = nil
    assert_not @intro_quiz.valid?
  end
end
