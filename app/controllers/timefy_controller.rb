# Copyright (c) 2016 Geza Benko - <geza.benko+github@gmail.xom>.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA
#

require 'timefy'

class TimefyController < ApplicationController
  unloadable

  before_filter :find_project, :authorize

  def index
  end

  def file_upload

    if params[:file_upload].nil?
      flash[:error] = l(:timefy_error_not_found)
    else
      file = params[:file_upload][:my_file].tempfile

      begin
        count = Timefy::parse_file(file, @project, User.current)
        return redirect_to project_issues_path(@project), :notice => l(:issuefy_notice, count)
      rescue Ole::Storage::FormatError
        flash[:error] = l(:issuefy_error_wrong_format)
      rescue TimefyErrorValue => e
        flash[:error] = l(:issuefy_error_value, :value => e.message)
      rescue Exception => e
        flash[:error] = l(:issuefy_error_something, :message => e.message)
      end
    end

    redirect_to :action => :index
  end
end
