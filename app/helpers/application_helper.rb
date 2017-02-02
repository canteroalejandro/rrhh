module ApplicationHelper
	def is_active?(page_name)
	  "active" if params[:controller] == page_name
	end

	def pluralize_without_count count, singular, plural=nil
	  ((count == 1 || count =~ /^1(\.0+)?$/) ? singular : (plural || singular.pluralize))
	end

	def javascript(*files)
	  content_for(:head) { javascript_include_tag(*files) }
	end

	def date_server
	  return DateTime.now.httpdate
	end

	def ldate(dt, hash = {})
	  dt ? l(dt, hash) : nil
	end

	def human_boolean(boolean)
	    boolean ? 'Si' : 'No'
	end
end
