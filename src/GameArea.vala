using Gtk;


namespace CubeGame {
	
	

	public class GameArea : HBox {
		
		
	    private int final_count_x;
	    private int final_count_y;
	    private int color_to_find=0;
	    
	    public int vb=24;
	    public int hb=20;
	    public int game_piece_size=16;
	    public int game_piece_max_color=3;
	    
	    public bool Debug = false;
	    public signal void check_mark_event (); 
		public signal void score_event (int score); 
		private int Score = 0;
		            
		public GameArea() {
	        this.set_homogeneous(true);
	        this.set_spacing(1);
	    }
	    
	    public void reset_game() {
			this.foreach((vba) => {
					vba.destroy();
				});
		    start_game();
	    }
	    
	    public void start_game(){
		    Score=0;
		    int x=0;
			for (int a = 0; a < vb; a++) this.add(new VBox (false, 1));
			this.foreach((vba) => {
					weak VBox vbb = vba as VBox;
				        for (int b = 0; b < hb; b++) {
							var cube = new CubeWidget (x, this, game_piece_size, game_piece_max_color);
							Debug = false;
							cube.Debug = Debug;
							cube.selected_event.connect(mouse_pressed);
							vbb.pack_end(cube,false,false,0);
							x++;
					    }
										
				 });
			score_event(Score);	
	    }
	    
	 	public void mouse_pressed (int the_one, int col) {
			color_to_find = col;
	    	find_the_one(the_one);
	    	start_mark_check ();	
		}
	
		public void find_the_one(int the_one){
			weak CubeWidget c = null;
			for(int x=0;x<vb;x++){
				for(int y=0;y<get_count_coloum(x);y++){	
					c = get_CubeWidget (x,y);
					if(c.Number == the_one){
						final_count_x = x;
						final_count_y = y;	
					}
				}
			}
		}
		
		private void start_mark_check () {
			int g=0;
			countinue_mark_check(final_count_x, final_count_y, ref g);
			//if(Debug) stdout.printf ("start_mark_check x: %d / y: %d\n",final_count_x, final_count_y);
			check_mark_event ();
			Score++;
			score_event(Score);	
		}
		
		private void countinue_mark_check (int x, int y, ref int g) {
			if(g<(vb*hb*100)){
				g++;
				weak CubeWidget c = null;
				for(int i=0;i<4;i++){
					
					if(i==0) c = get_CubeWidget (x-1,y);
					if(i==1) c = get_CubeWidget (x+1,y);
					if(i==2) c = get_CubeWidget (x,y-1);
					if(i==3) c = get_CubeWidget (x,y+1);
					
					if(c!=null) {
						if (c.Color==color_to_find && c.Mark == false) {
						c.Mark = true;
						c.Color = 7;
						c.queue_draw();
						if(i==0) countinue_mark_check (x-1,y,ref g);
						if(i==1) countinue_mark_check (x+1,y,ref g);
						if(i==2) countinue_mark_check (x,y-1,ref g);
						if(i==3) countinue_mark_check (x,y+1,ref g);
						}
					}
				}
			}
		}
		
		private weak CubeWidget get_CubeWidget (int x, int y) {
			int b=get_count_coloum(x);
			int c=-1; 
			weak CubeWidget cwc = null;
			weak VBox vbc = null;
			//stdout.printf ("in x:%d / in y:%d / ",x,y);
			if(x<=0) x=0;
			if(x>=vb+1) x=vb+1;
			if(y<=0) y=0;
			if(y>=hb-1) y=hb-1;
			//stdout.printf ("out x:%d / out y:%d\n",x,y);
			this.foreach((vba) => {
					c++; 
					weak VBox vbb = vba as VBox;
					if(c==x){
						vbc = vbb;
					}
				 });
			
			if(vbc!=null){	 
			vbc.foreach((cwa) => {
					b--; 
					weak CubeWidget cwb = cwa as CubeWidget;
					if(b==y)cwc = cwb;
					});
			}
			return cwc;
		}
		
		private int get_count_coloum (int x) {
			int b=hb;
			int c=-1; 
			weak VBox vbc = null;
			if(x<=0) x=0;
			if(x>=vb+1) x=vb+1;
			this.foreach((vba) => {
					c++; 
					weak VBox vbb = vba as VBox;
					if(c==x){
						vbc = vbb;
					}
				 });
			
			if(vbc!=null){	
			vbc.foreach((cwa) => {
					b--; 
				 });
			//stdout.printf ("get_count_coloum x:%d / out:%d\n", x,b);
			}
			return hb - b;
		}
		
	}
			
	
}
