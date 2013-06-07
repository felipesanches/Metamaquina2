// (c) 2013 Metamáquina <http://www.metamaquina.com.br/>
//
// Author:
// * Felipe C. da S. Sanches <fsanches@metamaquina.com.br>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

use <rounded_square.scad>;
include <render.h>;
include <BillOfMaterials.h>;

thickness = 6;

feet_height = 10;
feet_width = 30;
base_height = 40;
total_height = 120;
total_width = 150;
top_cut_height = 15;
top_cut_width = 30;
radius = 10;
spool_holder_width = 180;
spool_holder_height = 30;

module FilamentSpoolHolder_sidepanel_face(){

  difference(){
    union(){
      hull()
      for (i=[-1,1]){
          translate([i*30,total_height])
          circle(r=radius);

          translate([i*(total_width/2-radius),base_height])
          circle(r=radius);

          translate([i*total_width/2,feet_height])
          circle(r=0.1);
      }

      for (i=[-1,1])
      translate([i*(total_width-feet_width)/2,10])
      rounded_square([feet_width,20], corners=[5, 5, 5, 5], center=true);
    }

    union(){
      translate([0,(total_height+feet_height-top_cut_height/2)])
      square([top_cut_width,top_cut_height],center = true);

      translate([0,(total_height+feet_height-top_cut_height)])
      circle(r=top_cut_width/2);
      }  
    }
  }

module FilamentSpoolHolder_othersidepanel_face(){
          translate([0,feet_height+spool_holder_height/2])
          #square([spool_holder_width-thickness,spool_holder_height],center = true);
    }

module FilamentSpoolHolder_sidepanel_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="Filament Spool Holder Side Panel");
  material("lasercut")
  linear_extrude(height=thickness)
  FilamentSpoolHolder_sidepanel_face();
}

module FilamentSpoolHolder_othersidepanel_sheet(){
  BillOfMaterials(category="Lasercut wood", partname="Filament Spool Holder Side Panel");
  material("lasercut")
  linear_extrude(height=thickness)
  FilamentSpoolHolder_othersidepanel_face();
}

module FilamentSpoolHolder(){
  for (i=[-1,1])
  translate([0, i*spool_holder_width/2])
  rotate([90,0,0])
  FilamentSpoolHolder_sidepanel_sheet();
}

module FilamentSpoolHolder_othersidepanel(){
  for (i=[-1,1])
  translate([0, i*(total_width/2-thickness/2)])
  rotate([90,0,0])
  FilamentSpoolHolder_othersidepanel_sheet();
}
  translate([-thickness/2,-thickness/2])
  rotate([0,0,90])

FilamentSpoolHolder();
FilamentSpoolHolder_othersidepanel();
