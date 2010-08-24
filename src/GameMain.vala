using Gtk;
using Gdk;


namespace CubeGame {
			
	public class GameBar : Gtk.Statusbar {
	
		private uint Score_id = 0;
			
		public GameBar(CubeGame.GameArea game) {
		 	game.score_event.connect(ScoreChange);
			has_resize_grip = false;
			Score_id = get_context_id("Score");
			ScoreChange(0);
		}
			
	    public void ScoreChange(int score) {
			push(Score_id,"Score: " + score.to_string());
		}
	}
	
	public class GameWindow : Gtk.Window {
		
		private CubeGame.GameArea game;
		private VBox vbox;
				
		public GameWindow() {
			game = new CubeGame.GameArea ();
			setup_game(32,24,20,3);
			game.start_game();
			create_menu();
			this.show_all();
		}
		
		private void create_menu(){
			var mbar = new MenuBar();
	        var menu = new Menu();
	        
	        var main = new MenuItem.with_label ("Menu"); 
	        mbar.add(main);
	        main.set_submenu(menu);
	        
	        var rstart = new MenuItem.with_label ("Restart"); 
	        rstart.activate.connect(restart);
	        menu.add(rstart);
	        
	        var easy = new MenuItem.with_label ("Easy"); 
	        easy.activate.connect(easy_event);
	        menu.add(easy);
	        
	        var medium = new MenuItem.with_label ("Medium"); 
	        medium.activate.connect(medium_event);
	        menu.add(medium);
	        
	        var hard = new MenuItem.with_label ("Hard"); 
	        hard.activate.connect(hard_event);
	        menu.add(hard);
	        
	        var exit = new MenuItem.with_label ("Exit"); 
	        exit.activate.connect(Gtk.main_quit);
	        menu.add(exit);
	        
	        var sbar = new CubeGame.GameBar (game);
	        vbox = new VBox (false, 1);
	        vbox.pack_start (mbar, false, true, 0);
	        vbox.add (game);
	        vbox.pack_start (sbar, false, true, 0);
	        bg_color();
	        add (vbox);
		}
		
		private void restart(){
			game.reset_game();
			this.show_all();
		}
		
		private void easy_event(){
			setup_game(24,18,27,2);
			change_game();
		}
		
		private void medium_event(){
			setup_game(32,24,20,3);
			change_game();
		}
		
		private void hard_event(){
			setup_game(40,30,16,4);
			change_game();
		}
		
		private void change_game(){
			game.reset_game();
			this.resize(1,1);
			this.show_all();	
		}
				
		private void setup_game (int vb, int hb, int size, int maxcolor){
			game.vb = vb;
			game.hb = hb;
			game.game_piece_size = size;
			game.game_piece_max_color = maxcolor;
		}
		
		private void bg_color()
		{
			var bg = Color();
	        bg.blue = 1;
	        bg.green = 1;
	        bg.red = 1;
	        modify_bg(StateType.NORMAL, bg);
		}
	}
		
	static int main (string[] args) {
        Gtk.init (ref args);
        var window = new GameWindow();
        window.destroy += Gtk.main_quit;
        window.show_all ();
        Gtk.main ();
        return 0;
	}	
}
