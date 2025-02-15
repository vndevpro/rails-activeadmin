# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  controller do
    include Admin::DashboardHelper
  end

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    render partial: 'admin/dashboard/customization'

    from_date = Admin::CustomizationHelper.parse_date(params[:from], Date.today.last_year)
    to_date = Admin::CustomizationHelper.parse_date(params[:to], Date.today)
    is_bar_chart = Admin::CustomizationHelper.is_bar_chart(params[:chart_type])

    columns do
      column do
        panel "Recent Posts" do
          
        end
      end

      column do
        panel "System Info" do
          para "Latest Migration: #{latest_migration}"
          para "Ruby Version: #{RUBY_VERSION}"
          para "Rails Version: #{Rails.version}"
        end
      end
    end
  end # content
end
