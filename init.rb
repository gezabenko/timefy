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

Redmine::Plugin.register :timefy do
  name 'Timefy'
  author 'Geza Benko'
  description 'Redmine plugin, for creating time entries from a spreadsheet file'
  version '0.0.3'
  url 'http://github.com/gezabenko/timefy'
  author_url 'http://github.com/gezabenko'
  permission :timefy, { :timefy => [:index, :file_upload] }
  menu :project_menu , :timefy, {:controller => 'timefy', :action => 'index'}, :caption => :timefy
end
