--
-- PostgreSQL database dump
--

-- Dumped from database version 11.0
-- Dumped by pg_dump version 11.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: collection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.collection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.collection_id_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: collections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.collections (
    user_id integer,
    collection_id integer DEFAULT nextval('public.collection_id_seq'::regclass) NOT NULL,
    collection_name character varying(255) NOT NULL,
    public_bool boolean DEFAULT true NOT NULL,
    is_featured boolean DEFAULT false NOT NULL
    num_favorites integer NOT NULL DEFAULT 0,
);


ALTER TABLE public.collections OWNER TO postgres;

--
-- Name: comic; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comic (
    comic_id integer NOT NULL,
    comic_image text DEFAULT ''::text NOT NULL,
    comic_title text DEFAULT ''::text NOT NULL,
    comic_description text DEFAULT ''::text NOT NULL,
    comic_release_date date DEFAULT CURRENT_DATE NOT NULL,
    comic_creators text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.comic OWNER TO postgres;

--
-- Name: comic_collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comic_collection (
    comic_id integer NOT NULL,
    collection_id integer NOT NULL
);


ALTER TABLE public.comic_collection OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    email character varying(255) NOT NULL,
    username character varying(30) NOT NULL,
    password character varying(32) NOT NULL,
    salt character varying(256) NOT NULL,
    role character varying(255) DEFAULT 'standard'::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: collections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.collections (user_id, collection_id, collection_name, public_bool, is_featured) FROM stdin;
1	1	Top 10 SPIDER-MAN Stories	t	f
2	2	test	t	f
3	3	The 7 Most Essential Iron Man Comics	t	f
4	4	SMASH HITS: THE 10 STRONGEST HULK STORIES	t	f
5	5	10 Greatest Thor Stories of All Time	t	f
6	6	The 10 Best Wolverine Stories	t	f
7	7	Grant Morrison's New X-Men	t	f
7	8	Howard the Duck	t	f
7	9	Fantastic Four	t	f
\.


--
-- Data for Name: comic; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comic (comic_id, comic_image, comic_title, comic_description, comic_release_date, comic_creators) FROM stdin;
14964	http://i.annihil.us/u/prod/marvel/i/mg/b/f0/4bb72506caf2f/detail.jpg	New X-Men (2001) #145	ASSAULT ON WEAPON + PART 4 Now in the Weapon + nerve center, in Earth orbit, the mutant trio attempt to take the whole operation down. Can they destroy Weapon XV? Plus, Wolverine finds his own Weapon + project files! What will he learn?	2003-09-24	[{"name":"Chris Bachalo","role":"penciller"},{"name":"Grant Morrison","role":"writer"},{"name":"Tim Townsend","role":"inker"}]
6913	http://i.annihil.us/u/prod/marvel/i/mg/3/f0/4d71385c4b966/detail.jpg	The Amazing Spider-Man (1963) #90		1970-11-10	[{"name":"Gil Kane","role":"penciller (cover)"},{"name":"Stan Lee","role":"editor"},{"name":"Sam Rosen","role":"letterer"}]
6869	http://i.annihil.us/u/prod/marvel/i/mg/c/50/57aa2d678be0d/detail.jpg	The Amazing Spider-Man (1963) #50		1967-07-10	[{"name":"Mike Esposito","role":"inker"},{"name":"Stan Lee","role":"editor"},{"name":"John Romita Jr.","role":"penciller (cover)"},{"name":"Sam Rosen","role":"letterer"}]
6817	http://i.annihil.us/u/prod/marvel/i/mg/6/10/57e0016b50fc8/detail.jpg	The Amazing Spider-Man (1963) #400		1995-04-10	[{"name":"Oakley","role":"letterer"},{"name":"Mark Bagley","role":"penciller"},{"name":"Bob Budiansky","role":"editor"},{"name":"Danny Fingeroth","role":"editor"},{"name":"J. M. DeMatteis","role":"writer"},{"name":"Randy Emberlin","role":"inker"},{"name":"Larry Mahlstedt","role":"inker"},{"name":"Bob Sharen","role":"colorist"}]
6738	http://i.annihil.us/u/prod/marvel/i/mg/e/70/57a0cce2aa7c0/detail.jpg	The Amazing Spider-Man (1963) #33	A beaten, bruised and nearly broken Spider-Man overcomes all obstacles in his way, pushing past all known limits to survive and fight another day.	1966-02-10	[{"name":"Steve Ditko","role":"penciller (cover)"},{"name":"Stan Lee","role":"editor"}]
6636	http://i.annihil.us/u/prod/marvel/i/mg/f/a0/57c5edef425ae/detail.jpg	The Amazing Spider-Man (1963) #238		1983-03-10	[{"name":"Tom Defalco","role":"editor"},{"name":"John Romita Jr.","role":"artist"},{"name":"John Romita Sr.","role":"artist"},{"name":"Joe Rosen","role":"letterer"},{"name":"Roger Stern","role":"writer"},{"name":"Andy Yanchus","role":"colorist"}]
6508	http://i.annihil.us/u/prod/marvel/i/mg/9/60/57b72b0d9b47b/detail.jpg	The Amazing Spider-Man (1963) #122		1973-07-10	[{"name":"Gerry Conway","role":"writer"},{"name":"Gil Kane","role":"penciller"},{"name":"Tony Mortellaro","role":"inker"},{"name":"Roy Thomas","role":"editor"}]
1271	http://i.annihil.us/u/prod/marvel/i/mg/9/70/5b6a18f76c0b7/detail.jpg	Spider-Man: Blue (Trade Paperback)	Available for the first time in affordable trade paperback format - Jeph Loeb & Tim Sale present this lavish look back at a pivotal era for the Amazing Spider-Man - including the introduction of Peter's first love, Gwen Stacy; his growing relationship with Mary Jane Watson; his budding friendship with Harry Osborn; and Spider-Man's startling final battle against the Green Goblin.	2004-04-07	[{"name":"Wes Abbot","role":"letterer"},{"name":"Richard Starkings","role":"letterer"},{"name":"Paul Tutrone","role":"letterer"},{"name":"Kia Asamiya","role":"penciller"},{"name":"Greg Capullo","role":"penciller"},{"name":"Tim Sale","role":"penciller"},{"name":"Chuck Austen","role":"writer"},{"name":"Stan Lee","role":"writer"},{"name":"Jeph Loeb","role":"writer"},{"name":"Ron Zimmerman","role":"writer"},{"name":"Steve Buccellato","role":"colorist"},{"name":"Dan Kemp","role":"colorist"},{"name":"J.d. Smith","role":"colorist"},{"name":"Danny K. Miki","role":"inker"}]
12028	http://i.annihil.us/u/prod/marvel/i/mg/3/20/5970ca8b15116/detail.jpg	Web of Spider-Man (1985) #32		1987-11-10	[{"name":"J. M. DeMatteis","role":"writer"},{"name":"Janet Jackson","role":"colorist"},{"name":"Bob Mcleod","role":"inker"},{"name":"Bill Oakley","role":"letterer"},{"name":"Rick Parker","role":"letterer"},{"name":"Jim Salicrup","role":"editor"},{"name":"Jim Shooter","role":"editor"},{"name":"Michael Zeck","role":"penciller (cover)"}]
24419	http://i.annihil.us/u/prod/marvel/i/mg/2/50/4e8a0bdd8d3ed/detail.jpg	Amazing Spider-Man (1999) #612	They're Hunting Spiders...THE GAUNTLET begins here\r\nThe event that redefines Spider-Man's classic arch-enemies one by one starts with one of his deadliest - Electro!  Destitute and desperate, conned out of his life's meaning and worth-Max Dillon becomes the voice of the common man against the brutal injustice of a system overloaded by greed. With Spider-Man already looking over his shoulder. Mark Waid and Paul Azaceta bring you the story of a hero with everything to lose against a man with nothing left to gain. Prepare for death's short, sharp shock. Prepare for Electro.\r\nRated A ...$3.99	2009-11-18	[{"name":"Paul Azaceta","role":"penciller"},{"name":"Vc Joe Caramagna","role":"letterer"},{"name":"Marko Djurdjevic","role":"penciller (cover)"},{"name":"Dave Stewart","role":"colorist"},{"name":"Stephen Wacker","role":"editor"},{"name":"Mark Waid","role":"writer"}]
43137	http://i.annihil.us/u/prod/marvel/i/mg/8/e0/57a3460d4d5aa/detail.jpg	Amazing Spider-Man (1999) #38		2002-02-02	[]
72686	http://i.annihil.us/u/prod/marvel/i/mg/4/20/5b61c9b688384/detail.jpg	Iron Man: The Iron Age (1998) #1	Through the perspective of Pepper Potts, we learn of Tony Stark’s origin: through his rise as CEO of Stark Industries, to his first turn as Iron Man.	1998-08-01	[{"name":"Kurt Busiek","role":"writer"},{"name":"Bob Mcleod","role":"penciller (cover)"},{"name":"Patch Zircher","role":"penciller (cover)"},{"name":"Glynis Oliver","role":"colorist"},{"name":"Richard Starkings","role":"letterer"}]
31425	http://i.annihil.us/u/prod/marvel/i/mg/a/90/5ac3b0ad0a211/detail.jpg	Iron Man: Demon in a Bottle (Trade Paperback)	Corporate connivances, murder charges, villains by the dozen - it's enough to drive a man to drink.   Action in Atlantic City, mayhem in Monaco - no one in the jet set finds trouble quicker than Iron Man in this character-defining story arc! Attacked in both identities, will Tony Stark drown them both along with his sorrows? Plus: Iron Man's origin told in detail! Also featuring the Avengers, Ant-Man and Namor the Sub-Mariner! Collecting IRON MAN #120-128.\r\nRated T  ...$24.99\r\nISBN: 0-7851-2043-2	2010-03-03	[]
29070	http://i.annihil.us/u/prod/marvel/i/mg/f/30/4bb3c67ee18ca/detail.jpg	Iron Man: Iron Monger (Hardcover)	He's lost his armor and his fortune, but not his nerve! Tony Stark's back on his feet after everything Obadiah Stane has thrown at him, but now the bilious billionaire is taking away Stark's friends...one of them forever! The enmity spanning more than thirty issues ends in a steel-plated slugfest from which only one can walk away! Plus: vision quests and extradimensional intrigue! Madame Masque and Thundersword! And the debut of the Scourge of the Underworld! Guest-starring the West Coast Avengers! Collecting IRON MAN (1968) #193-200.\r\nRated T  ...$29.99\r\nISBN: 978-0-7851-4288-1	2010-03-17	[{"name":"Mark Bright","role":"penciller"},{"name":"Rich Buckler","role":"penciller"},{"name":"Sal Buscema","role":"penciller"},{"name":"Luke McDonnell","role":"penciller"},{"name":"Herb Trimpe","role":"penciller"}]
20933	http://i.annihil.us/u/prod/marvel/i/mg/d/40/4bb88d9d47e9a/detail.jpg	Iron Man Vs. Doctor Doom: Doomquest (Hardcover)	When armors collide! Trapped in the time-lost land of King Arthur, Iron Man battles Doctor Doom in a classic clash of titans! And in the far-flung future of 2093 A.D., the Armored Avenger and Doom must team up...to save Camelot! Collecting IRON MAN #149-150 and #249-250.\r<br>144 PGS./Rated A ...$19.99 \r<br>	2008-03-26	[{"name":"David Michelinie","role":"writer"}]
19898	http://i.annihil.us/u/prod/marvel/i/mg/c/60/5a5f84ea13ee4/detail.jpg	Iron Man (1998) #26		2000-03-01	[{"name":"Kurt Busiek","role":"writer"},{"name":"Bobbie Chase","role":"editor"},{"name":"Sean Chen","role":"artist"},{"name":"Robert Hunter","role":"inker"},{"name":"Steve Oliff","role":"colorist"},{"name":"Troy Peteri","role":"letterer"},{"name":"Joe Quesada","role":"penciler"}]
5872	http://i.annihil.us/u/prod/marvel/i/mg/6/70/52c5a3cf73358/detail.jpg	Iron Man: Armor Wars (Trade Paperback)	"How many? How many have drawn blood with my sword?" Millionaire industrialist Tony Stark is an inventive genius who has dedicated all of his enormous financial and intellectual resources to a single guiding principle: the creation of technology for the betterment of humanity. Stark's greatest creation is a modern-day miracle: a suit of form-fitting, strength-enhancing, steel-mesh armor he dons to become the living symbol of his ideals, the Invincible Iron Man! But when Stark discovers that the same technology he used to create the Iron Man armor - technology so secret he didn't even dare patent it - is now in the hands of several deadly super-villains, he feels responsible for the evil they have done with the high-tech tools he unwittingly provided. In the face of objections from his government, friends, colleagues and fellow super heroes, Stark swears to use the power of Iron Man to bring the evil to an end - and to take back what's his. The Beatle, Stilt Man, the Controller, Stingray, the Mandroids, the Guardsmen and Firepower don't know it yet, but they've got a problem. The world's most powerful force for good isn't playing by the rules anymore. And he's coming for them. Collecting IRON MAN #225-232.\r\n208 PGS./Rated A ...$24.99	2010-03-03	[{"name":"Mark Gruenwald","role":"editor"},{"name":"David Michelinie Barry WindsorSmith","role":"editor"},{"name":"David Michelinie","role":"writer"},{"name":"Bill Oakley","role":"letterer"},{"name":"Bob Sharen","role":"colorist"},{"name":"Barry Windsor-Smith","role":"penciller (cover)"}]
5816	http://i.annihil.us/u/prod/marvel/i/mg/7/70/5989f7e82d5a1/detail.jpg	Iron Man: Extremis (Trade Paperback)	It's the beginning of a new era for Iron Man as renowned scribe Warren Ellis joins forces with artist Adi Granov to redefine the armored Avenger's world for the 21st century - a landscape of terrifying new technologies that threaten to overwhelm fragile mankind! What is Extremis, who has unleashed it, and what does its emergence portend for the world? Collecting IRON MAN #1-6.\r<br>160 PGS./Rated T+ ...$14.99\r<br>	2007-01-31	[{"name":"Tom Brevoort","role":"editor"},{"name":"Warren Ellis","role":"writer"},{"name":"Vc Randy Gentile","role":"letterer"},{"name":"Adi Granov","role":"penciller"}]
52333	http://i.annihil.us/u/prod/marvel/i/mg/4/60/5554f961287fe/detail.jpg	Planet Hulk (2015) #1	A forbidden zone of wild HULKS A battle-worn gladiator named STEVE ROGERS A journey that could break the spirit of a world's greatest freedom fighter. PLUS: A back up story by a surprise creative team!	2015-05-20	[{"name":"Sam Humphries","role":"writer"},{"name":"Marc Laming","role":"artist"},{"name":"Mike Del Mundo","role":"penciller (cover)"}]
17198	http://i.annihil.us/u/prod/marvel/i/mg/9/60/5b75a65ed20e6/detail.jpg	Incredible Hulk (1962) #181		1974-11-01	[{"name":"Jack Abel","role":"inker"},{"name":"Artie Simek","role":"letterer"},{"name":"Roy Thomas","role":"editor"},{"name":"Herb Trimpe","role":"artist"},{"name":"Glynis Wein","role":"colorist"},{"name":"Len Wein","role":"writer"}]
15873	http://i.annihil.us/u/prod/marvel/i/mg/f/03/4f674b7218168/detail.jpg	World War Hulk (2007) #1	Exiled by a group of Marvel "heroes" to the savage alien planet of Sakaar, the Hulk raged, bled and conquered through the pages of the "Planet Hulk" epic, rising from slave to gladiator to king. Now the Hulk returns to Earth to wreak his terrible vengeance on Iron Man, Reed Richards, Dr. Strange and Black Bolt -- and anyone else who gets in his way.	2007-06-13	[{"name":"Virtual Calligr","role":"letterer"},{"name":"David Finch","role":"penciller (cover)"},{"name":"Klaus Janson","role":"inker"},{"name":"Greg Pak","role":"writer"},{"name":"John Romita Jr.","role":"penciller"},{"name":"Christina Strain","role":"colorist"}]
8951	http://i.annihil.us/u/prod/marvel/i/mg/c/30/4bb5416acff55/detail.jpg	Incredible Hulk (1962) #140		1971-06-10	[{"name":"Harlan Ellison","role":"writer"},{"name":"Roy Thomas","role":"writer"},{"name":"Sam Grainger","role":"inker"},{"name":"Stan Lee","role":"editor"},{"name":"Artie Simek","role":"letterer"},{"name":"Herb Trimpe","role":"penciller (cover)"}]
11708	http://i.annihil.us/u/prod/marvel/i/mg/3/50/4bb5823c43457/detail.jpg	Thor (1966) #380		1987-06-10	[{"name":"Craig Anderson","role":"editor"},{"name":"Ralph Macchio","role":"editor"},{"name":"Sal Buscema","role":"inker"},{"name":"Christie Scheele","role":"colorist"},{"name":"Walter Simonson","role":"writer"}]
11482	http://i.annihil.us/u/prod/marvel/i/mg/5/f0/4d4352fda1156/detail.jpg	Thor (1966) #154		1968-07-10	[{"name":"Vince Colletta","role":"inker"},{"name":"Stan Lee","role":"editor"},{"name":"Artie Simek","role":"letterer"}]
875	http://i.annihil.us/u/prod/marvel/i/mg/f/30/59cbd22f71dcb/detail.jpg	Thor (1998) #85	AVENGERS DISASSEMBLED TIE-IN! "RAGNAROK" PART 6 (OF 6) It's the end of all that is, and you've got a ringside seat for the last day of the Norse Gods, as Thor struggles to break the god cycle once and for all!  You must read this, True Believer - and here	2004-12-01	[{"name":"Vc Randy Gentile","role":"letterer"},{"name":"Michael Avon Oeming","role":"writer"},{"name":"Laura Villari","role":"colorist"},{"name":"Andrea DI Vito","role":"penciler"}]
21650	http://i.annihil.us/u/prod/marvel/i/mg/1/80/4bb5d061cdabe/detail.jpg	Kitty Pryde and Wolverine (1984) #6	Kitty must choose Ogun's fate. Will she allow him to live or condemn him to death?	1985-04-10	[{"name":"Chris Claremont","role":"writer"},{"name":"Al Milgrom","role":"penciller (cover)"},{"name":"Ann Nocenti","role":"editor"},{"name":"Tom Orzechowski","role":"letterer"},{"name":"Glynis Wein","role":"colorist"}]
21330	http://i.annihil.us/u/prod/marvel/i/mg/6/90/5899faf0241c2/detail.jpg	Wolverine (2003) #66	"OLD MAN LOGAN" Part 1 (of 8)\nMARK MILLAR and STEVE MCNIVEN (CIVIL WAR) bring us the most important WOLVERINE story of the 21st Century. Nobody knows what happened the night the heroes fell. What happened to Wolverine is the biggest mystery.	2008-06-18	[{"name":"John Barber","role":"editor"},{"name":"Virtual Calligr","role":"other"},{"name":"Morry Hollowell","role":"colorist"},{"name":"Steve Mcniven","role":"penciller"},{"name":"Mark Millar","role":"writer"},{"name":"Cory Petit","role":"letterer"},{"name":"Dexter Vines","role":"inker"}]
20852	http://i.annihil.us/u/prod/marvel/i/mg/9/30/4d252662dbf2e/detail.jpg	Logan (2008) #1	Wolverine's memories have returned. Now armed with the knowledge of all his triumphs and misdeeds, he sets off for the site of one his first major battles to rediscover the man known as Logan.	2008-03-05	[{"name":"Vc Joe Caramagna","role":"letterer"},{"name":"EDUARDO RISSO","role":"penciller (cover)"},{"name":"Brian K. Vaughan","role":"writer"},{"name":"Dean White","role":"colorist"}]
6593	http://i.annihil.us/u/prod/marvel/i/mg/4/50/5192af7c78397/detail.jpg	The Amazing Spider-Man (1963) #2	The Vulture's rampage in Manhattan begins. Can Spidey take down the avian menace?	1963-05-10	[]
6592	http://i.annihil.us/u/prod/marvel/i/mg/3/90/57c479f0b0643/detail.jpg	The Amazing Spider-Man (1963) #199		1979-12-10	[{"name":"Sal Buscema","role":"artist"},{"name":"Pablo Marcos","role":"inker"},{"name":"Jim Mooney","role":"penciller"},{"name":"Joe Rosen","role":"letterer"},{"name":"George Roussos","role":"colorist"},{"name":"Marv Wolfman","role":"editor"}]
12398	http://i.annihil.us/u/prod/marvel/i/mg/9/00/58a1efc12a086/detail.jpg	Incredible Hulk: The End (2002) #1		2002-08-01	[{"name":"Tom Brevoort","role":"editor"},{"name":"Bobbie Chase","role":"editor"},{"name":"Peter David","role":"writer"},{"name":"Dan Kemp","role":"colorist"},{"name":"Dale Keown","role":"penciller (cover)"},{"name":"Joe Weems","role":"inker"}]
11681	http://i.annihil.us/u/prod/marvel/i/mg/9/e0/4bc46fd181f79/detail.jpg	Thor (1966) #353	Thor and Odin have been defeated! Now Surtur is free to enact his devious plan. But is there no one left to stand against him? What of Loki? Can the God of Mischief put aside his tricks to save his kingdom?	1985-03-10	[{"name":"Mark Gruenwald","role":"editor"},{"name":"Howard Mackie","role":"editor"},{"name":"Christie Scheele","role":"colorist"},{"name":"Walter Simonson","role":"penciller (cover)"}]
12168	http://i.annihil.us/u/prod/marvel/i/mg/4/00/5854497f12e1f/detail.jpg	Wolverine (1982) #1	He's the best there is at what he does. But what he does isn't very\nnice. See Wolverine do lots of not-nice things, like fighting a bear in\nthe Canadian Rockies! Sword-fighting with one of his greatest foes, Lord\nShingen! And fighting for the honor of his lady love, Mariko Yashida,\nagainst...her husband?!?	1982-09-10	[{"name":"Chris Claremont","role":"writer"},{"name":"Louise Jones","role":"editor"},{"name":"Frank Miller","role":"penciller (cover)"},{"name":"Glynis Oliver","role":"colorist"},{"name":"Glynis Wein","role":"colorist"},{"name":"Tom Orzechowski","role":"letterer"},{"name":"Josef Rubinstein","role":"inker"}]
10575	http://i.annihil.us/u/prod/marvel/i/mg/6/b0/51e417973ecc5/detail.jpg	Origin (2001) #2	What are the Howlett family secrets? What is the fate of the Logans? Who will die before Wolverine is born in blood?	2001-12-01	[{"name":"Wes Abbot","role":"letterer"},{"name":"Oscar Gongora","role":"letterer"},{"name":"Bill Jemas","role":"writer"},{"name":"Andy Kubert","role":"penciller"},{"name":"Mike Marts","role":"editor"},{"name":"Mike Raicht","role":"editor"},{"name":"Joe Quesada","role":"penciller (cover)"}]
70110	http://i.annihil.us/u/prod/marvel/i/mg/2/20/5cacf715cdee1/detail.jpg	West Coast Avengers (2018) #10	THE GOOD, THE BAD & THE BEAUTIFUL CONCLUDES! HAWKEYE and HAWKEYE lead the fight to save AMERICA CHAVEZ from a cult that believes she’s their prophesized chosen one who will lead them into the light — and also into victory — as they attempt a takeover of Los Angeles. But just as things look darkest, the team is joined by a mysterious and powerful new ally. Amid flying arrows and punching fists, relationships are both blossoming and being torn apart — what does it all mean for the future of the West Coast Avengers?!\n	2019-04-17	[{"name":"Vc Joe Caramagna","role":"letterer"},{"name":"Triona Farrell","role":"colorist"},{"name":"Gang Hyuk Lim","role":"painter (cover)"},{"name":"Eduard Petrovich","role":"penciler (cover)"},{"name":"Alanna Smith","role":"editor"},{"name":"Kelly Thompson","role":"writer"}]
13061	http://i.annihil.us/u/prod/marvel/i/mg/9/40/5aaa9a0a87539/detail.jpg	Fantastic Four (1961) #25	The battle you've been waiting for! The Incredible Hulk vs. the Ever Lovin' Blue-Eyed Thing! Nuff said!\n	1964-04-10	[{"name":"Jack Kirby","role":"penciller"},{"name":"Stan Lee","role":"writer"},{"name":"Sam Rosen","role":"letterer"},{"name":"George Roussos","role":"inker"}]
365	http://i.annihil.us/u/prod/marvel/i/mg/3/a0/5b980f0495d14/detail.jpg	Hulk: Gray (2003) #1	Travel back to the early days of the Hulk, before he was the Jade Giant, and discover one of his first conflicts with General Ross. See how the Hulk fell in love for the first time! And watch him destroy!\n	2003-10-15	[{"name":"Matt Hollingsworth","role":"colorist"},{"name":"Jeph Loeb","role":"writer"},{"name":"Tim Sale","role":"penciller (cover)"},{"name":"Richard Starkings","role":"letterer"}]
11665	http://i.annihil.us/u/prod/marvel/i/mg/5/03/4d70502665d36/detail.jpg	Thor (1966) #337	Nick Fury asks Thor's aid in investigating an alien ship heading for Earth. Thor arrives and triggers the awakening of an alien protector, Beta Ray Bill. But when Bill bests Thor and takes up his hammer, he is summoned to Asgard by Odin!	1983-11-10	[{"name":"Mark Gruenwald","role":"editor"},{"name":"George Roussos","role":"colorist"},{"name":"Walter Simonson","role":"penciller (cover)"},{"name":"John Workman Jr.","role":"letterer"}]
11454	http://i.annihil.us/u/prod/marvel/i/mg/e/30/4f63909280397/detail.jpg	Thor (1966) #126		1966-03-10	[{"name":"Vince Colletta","role":"inker"},{"name":"Jack Kirby","role":"penciller (cover)"},{"name":"Stan Lee","role":"editor"},{"name":"Artie Simek","role":"letterer"}]
73008	http://i.annihil.us/u/prod/marvel/i/mg/c/00/5cacf37f334b1/detail.jpg	Star Wars: Age of Rebellion Special (2019) #1	A ONE-SHOT SPECIAL FEATURING YOUR FAVORITE (AND UNEXPECTED) CHARACTERS FROM THE ORIGINAL STAR WARS TRILOGY! Move over, Boba Fett. The most dangerous bounty hunter in the galaxy isn’t who you think. The cold, calculating assassin droid IG-88 had a deadly reputation. Wanted criminals should tremble in fear because IG-88 will stop at nothing to get the job done. But where did it come from? What does it want? Perfection might be a good place to start. SI SPURRIER (DOCTOR APHRA) and CASPAR WIJNGAARD (DOCTOR APHRA ANNUAL) bring the terrifying droid to life! The destruction of the Order, the death of his friends, exile — no matter what he has endured, YODA will always be a Jedi. Even in hiding on the isolated planet of Dagobah, far from the evil Empire’s reach, a Jedi’s work is never done. Marc Guggenheim (X-MEN GOLD) and ANDREA BROCCARDO (STAR WARS) will pay the wise, old master a visit! The freedom-fighting REBEL ALLIANCE has more than its fair share of heroes — like ace pilots BIGGS DARKLIGHTER and JEK PORKINS. But they’ve been fighting the evil Galactic Empire for a long time and sometimes, even noble warriors like Biggs and Porkins need a little rest and relaxation. Is anywhere truly free from the trials of the galactic conflict? Writer and illustrator JON ADAMS (the New Yorker, LOVE ROMANCES) has the answer!\n	2019-04-17	[{"name":"Jon Adams","role":"inker"},{"name":"Andrea Broccardo","role":"inker"},{"name":"Caspar Wijngaard","role":"inker"},{"name":"Giuseppe Camuncoli","role":"penciler (cover)"},{"name":"Guru Efx","role":"colorist (cover)"},{"name":"Marc Guggenheim","role":"writer"},{"name":"Si Spurrier","role":"writer"},{"name":"Lee Loughridge","role":"colorist"},{"name":"Dono Sanchez-&#8203;Almara","role":"colorist"},{"name":"Mark Paniccia","role":"editor"}]
16088	http://i.annihil.us/u/prod/marvel/i/mg/c/30/4bb87f7a4cc30/detail.jpg	Hulk: Future Imperfect (1992) #1		1992-12-10	[{"name":"Peter David","role":"writer"},{"name":"George Perez","role":"penciler"},{"name":"Joe Rosen","role":"letterer"},{"name":"Tom Smith","role":"colorist"}]
9111	http://i.annihil.us/u/prod/marvel/i/mg/c/20/4bb609ed6a1d5/detail.jpg	Incredible Hulk (1962) #300		1984-10-10	[{"name":"Bret Blevins","role":"penciller (cover)"},{"name":"Sal Buscema","role":"penciller"},{"name":"Bill Mantlo","role":"writer"},{"name":"Jim Novak","role":"letterer"},{"name":"Carl Potts","role":"editor"},{"name":"Bob Sharen","role":"colorist"}]
7174	http://i.annihil.us/u/prod/marvel/i/mg/f/03/4e8f156675036/detail.jpg	Avengers (1963) #3	Earth's mightiest heroes must face Marvel's mightiest malcontents: the Hulk and the Sub-Mariner, teaming up for the first time! Featuring the Fantastic Four and the X-Men!	1964-01-10	[{"name":"Jack Kirby","role":"penciller (cover)"},{"name":"Stan Lee","role":"editor"},{"name":"Paul Reinman","role":"inker"}]
44198	http://i.annihil.us/u/prod/marvel/i/mg/3/30/51646f6c2a712/detail.jpg	Thor: God of Thunder (2012) #1	Marvel Now! begins for the God of Thunder! The gods are vanishing, leading Thor on a bloody trail that threatens to consume his past, present and future. To save these worlds, Thor must unravel the gruesome mystery of the God Butcher!	2012-11-14	[{"name":"Jason Aaron","role":"writer"},{"name":"Virtual Calligr","role":"letterer"},{"name":"Joe Sabino","role":"letterer"},{"name":"Esad Ribic","role":"artist (cover)"},{"name":"Lauren Sankovitch","role":"editor"},{"name":"Dean White","role":"colorist"},{"name":"Dean V. White","role":"colorist"}]
30581	http://i.annihil.us/u/prod/marvel/i/mg/9/10/5835bb2c80a5d/detail.jpg	Thor the Mighty Avenger (2010) #2	Thor has been banished from Asgard by his father Odin. What has the young Thunder God done to incur the wrath of the All Father? Can Thor return to the paradise that is Asgard or will he doomed to walk the lowly Earth for all eternity?	2010-07-28	[{"name":"Roger Langridge","role":"writer"},{"name":"Chris Samnee","role":"penciller"}]
15943	http://i.annihil.us/u/prod/marvel/i/mg/4/40/4e94946086f3c/detail.jpg	Thor (2007) #1	Not a clone! Not a robot! Not an imaginary story! The God of Thunder is officially BACK! You've waited for it, you've demanded it...and we say thee YEA! The Odinson comes roaring to life but how does a god return from Ragnarok? And what place will he find in a world torn by CIVIL WAR?	2007-07-05	[{"name":"Olivier Coipel","role":"penciller (cover)"},{"name":"Laura Martin","role":"colorist"},{"name":"Mark Morales","role":"inker"},{"name":"J. Michael Straczynski","role":"writer"}]
11690	http://i.annihil.us/u/prod/marvel/i/mg/1/c0/4bc46ee1aafe0/detail.jpg	Thor (1966) #362	Thor and his fellow warriors are fleeing Hel when they are attacked yet again! At the Helgate the fellowship must do battle with the demons of Hel. And one of them must stand to defend Gjallerbru! Who shall it be?	1985-12-10	[{"name":"Craig Anderson","role":"editor"},{"name":"Ralph Macchio","role":"editor"},{"name":"Christie Scheele","role":"colorist"},{"name":"Walter Simonson","role":"penciller (cover)"},{"name":"John Workman Jr.","role":"letterer"}]
10155	http://i.annihil.us/u/prod/marvel/i/mg/3/03/53514654b32b8/detail.jpg	Marvel Comics Presents (1988) #72	Note: this issue contains only the Weapon X story by Barry Windsor-Smith.	1991-03-20	[{"name":"Kelly Corvese","role":"editor"},{"name":"Terry Kavanagh","role":"editor"},{"name":"Butch Guice","role":"penciller"},{"name":"Paul Gulacy","role":"penciller"},{"name":"Sandy Plunkett","role":"penciller"},{"name":"Javier Saltares","role":"penciller"},{"name":"Dwayne Turner","role":"penciller"},{"name":"Chris Ivy","role":"inker"},{"name":"Gary Martin","role":"inker"},{"name":"Mark Mckenna","role":"inker"},{"name":"Gerard Jones","role":"writer"},{"name":"Fabian Nicieza","role":"writer"},{"name":"Steve Matisson","role":"colorist"},{"name":"Jade Moede","role":"letterer"},{"name":"Jim Novak","role":"letterer"},{"name":"Barry Windsor-Smith","role":"penciller (cover)"}]
20642	http://i.annihil.us/u/prod/marvel/i/mg/6/70/58939a381ab3a/detail.jpg	Wolverine (2003) #62	GET MYSTIQUE PART 1 In the wake of Messiah Complex, Wolverine is on a mission of vengeance! But who is the focus of his rage, and what dark secret does he share with them? And how far over the edge is Wolverine willing to go to get what he wants?	2008-02-13	[{"name":"Jason Aaron","role":"writer"},{"name":"Axel Alonso","role":"editor"},{"name":"Vc Joe Caramagna","role":"letterer"},{"name":"Cory Petit","role":"letterer"},{"name":"Ron Garney","role":"penciller (cover)"},{"name":"Jason Keith","role":"colorist"}]
14965	http://i.annihil.us/u/prod/marvel/i/mg/9/10/4bc46b1e313f8/detail.jpg	New X-Men (2001) #146	PLANET X PART 1 The young mutant known as Dust runs rampant at the Xavier Institute as Xorn and his remedial class assist Professor X in his efforts to quell her.	2003-10-01	[{"name":"Phil Jimenez","role":"penciller"},{"name":"Grant Morrison","role":"writer"},{"name":"Ethan Van Sciver","role":"penciller (cover)"}]
14933	http://i.annihil.us/u/prod/marvel/i/mg/f/30/5140cda8ce9af/detail.jpg	New X-Men (2001) #114	E For Extinction Part 1 (of 3) Sixteen million mutants dead - and that's just the beginning! The destruction of Genosha is just the beginning of a new era for the X-Men.	2001-07-01	[{"name":"Brian Haberlin","role":"colorist"},{"name":"Grant Morrison","role":"writer"},{"name":"Mark Powers","role":"editor"},{"name":"Frank Quitely","role":"penciller (cover)"},{"name":"Saida Temofonte","role":"letterer"},{"name":"Tim Townsend","role":"inker"}]
14934	http://i.annihil.us/u/prod/marvel/i/mg/6/40/4bb793db72171/detail.jpg	New X-Men (2001) #115	E For Extinction Part 2 (of 3)  Cassandra Nova stands responsible for the murder of 16 million mutants and the X-Men are bringing her down - dead or alive!	2001-08-01	[{"name":"Grant Morrison","role":"writer"},{"name":"Mark Powers","role":"editor"},{"name":"Frank Quitely","role":"penciller (cover)"},{"name":"Saida Temofonte","role":"letterer"},{"name":"Tim Townsend","role":"inker"}]
14935	http://i.annihil.us/u/prod/marvel/i/mg/9/20/4c35efa48c052/detail.jpg	New X-Men (2001) #116	E For Extinction Part 3 (of 3)  The X-Men are the only force capable of taking down the manical Cassandra Nova.  Plus, has the White Queen joined the X-Men?  And Xavier makes a shocking decision!	2001-09-01	[{"name":"Grant Morrison","role":"writer"},{"name":"Mark Powers","role":"editor"},{"name":"Frank Quitely","role":"penciller (cover)"},{"name":"Saida Temofonte","role":"letterer"},{"name":"Tim Townsend","role":"inker"}]
14936	http://i.annihil.us/u/prod/marvel/i/mg/5/d0/4bc46b330096b/detail.jpg	New X-Men (2001) #117	Beast has got a busy day ahead of him. With a hot date planned for the evening and a training session with the mutant Beak during the day, what could go wrong?	2001-10-01	[{"name":"Grant Morrison","role":"writer"},{"name":"Mark Powers","role":"editor"},{"name":"Frank Quitely","role":"penciller (cover)"},{"name":"Prentiss Rollins","role":"inker"},{"name":"Tim Townsend","role":"inker"},{"name":"Ethan Van Sciver","role":"penciller"},{"name":"Saida Temofonte","role":"letterer"}]
14937	http://i.annihil.us/u/prod/marvel/i/mg/4/60/59764e96645ba/detail.jpg	New X-Men (2001) #118	GERM FREE GENERATION PART 1 The printing of the U-Men bible, "The Third Species", has incited a country-wide wave of violence. With Professor X gone and Beast in recovery from a mysterious attack, what are the X-Men to do?	2001-11-01	[{"name":"Grant Morrison","role":"writer"},{"name":"Mark Powers","role":"editor"},{"name":"Frank Quitely","role":"penciller (cover)"},{"name":"Ethan Van Sciver","role":"penciller"},{"name":"Saida Temofonte","role":"letterer"},{"name":"Tim Townsend","role":"inker"}]
14938	http://i.annihil.us/u/prod/marvel/i/mg/e/30/577c045684494/detail.jpg	New X-Men (2001) #119	GERM FREE GENERATION PART 2 While Wolverine is off rescuing and hopefully recruiting a new mutant, Cyclops and Emma Frost are captured by the U-Men! On the operating table and soon to be vivisected, Emma and Scott inches from death!	2001-12-01	[{"name":"Igor Kordey","role":"penciller"},{"name":"Grant Morrison","role":"writer"},{"name":"Mark Powers","role":"editor"},{"name":"Frank Quitely","role":"penciller (cover)"},{"name":"Saida Temofonte","role":"letterer"},{"name":"Tim Townsend","role":"inker"}]
14939	http://i.annihil.us/u/prod/marvel/i/mg/9/60/577c0c28e62cb/detail.jpg	New X-Men (2001) #120	GERM FREE GENERATION PART 3 The U-Men make their move on the X-Mansion! With four of their heaviest hitters away or out of commission, the X-Men are going to have to rely on Jean Grey to save the day!	2002-01-01	[{"name":"Igor Kordey","role":"penciller"},{"name":"Grant Morrison","role":"writer"},{"name":"Mark Powers","role":"editor"},{"name":"Frank Quitely","role":"penciller (cover)"},{"name":"Saida Temofonte","role":"letterer"},{"name":"Tim Townsend","role":"inker"}]
14940	http://i.annihil.us/u/prod/marvel/i/mg/2/d0/577c150a481a1/detail.jpg	New X-Men (2001) #121	SILENCE.  Emma Frost and Jean Grey take a trip inside the mind of Cassandra Nova to rescue the consciousness of Professor X! What dark secret does the Professor have trapped inside?	2002-02-01	[{"name":"Grant Morrison","role":"writer"},{"name":"Mark Powers","role":"editor"},{"name":"Frank Quitely","role":"penciller (cover)"},{"name":"Saida Temofonte","role":"letterer"}]
14941	http://i.annihil.us/u/prod/marvel/i/mg/c/30/4c35ef30a5f3f/detail.jpg	New X-Men (2001) #122	The Shi'Ar fleet is under siege and the empire threatens to crumble! All because of one person, the powerful sibling of Charles Xavier...Cassandra Nova! Can Lilandra and her disciples thwart this menace or will all be lost?	2002-03-01	[{"name":"Grant Morrison","role":"writer"},{"name":"Mark Powers","role":"editor"},{"name":"Frank Quitely","role":"penciller"},{"name":"Saida Temofonte","role":"letterer"},{"name":"Tim Townsend","role":"inker"}]
14942	http://i.annihil.us/u/prod/marvel/i/mg/c/e0/4c35ef277dd6e/detail.jpg	New X-Men (2001) #123	The Shi'Ar Imperial Guard have attacked! In a surgical two-pronged assault on the X-Men, Gladiator issues but one command to his subordinates: destroy all mutants! Plus, learn the secret behind the flu outbreak at the mansion!	2002-04-01	[{"name":"Mettier","role":"colorist"},{"name":"Snyder","role":"inker"},{"name":"Grant Morrison","role":"writer"},{"name":"Mark Powers","role":"editor"},{"name":"Ethan Van Sciver","role":"penciller"},{"name":"Saida Temofonte","role":"letterer"}]
14943	http://i.annihil.us/u/prod/marvel/i/mg/6/60/4c35ef154b276/detail.jpg	New X-Men (2001) #124	Lilandra has been convinced that the X-Men must be terminated with extreme prejudice. The X-Men are prepared to defend themselves, but how can they survive an engagement with Gladiator of the Imperial Guard?! Plus, Cyclops and Xorn escape!	2002-05-01	[{"name":"Igor Kordey","role":"penciller"},{"name":"Grant Morrison","role":"writer"},{"name":"Mark Powers","role":"editor"},{"name":"Frank Quitely","role":"penciller (cover)"},{"name":"Tim Townsend","role":"inker"}]
14944	http://i.annihil.us/u/prod/marvel/i/mg/f/70/4c35ee4eede60/detail.jpg	New X-Men (2001) #125	Cassandra Nova is unstoppable! As she blazes a furious trail toward Cerebra and complete psychic control over everything, the X-Men play their last card! Will it be enough?	2002-06-01	[{"name":"Igor Kordey","role":"penciller"},{"name":"Grant Morrison","role":"writer"},{"name":"Mark Powers","role":"editor"},{"name":"Ethan Van Sciver","role":"penciller (cover)"},{"name":"Richard Starkings","role":"letterer"},{"name":"Saida Temofonte","role":"letterer"}]
14945	http://i.annihil.us/u/prod/marvel/i/mg/9/50/577d157e06bba/detail.jpg	New X-Men (2001) #126		2002-07-01	[{"name":"Axel Alonso","role":"editor"},{"name":"Mike Marts","role":"editor"},{"name":"Mark Powers","role":"editor"},{"name":"Jimmy Betancourt","role":"letterer"},{"name":"Richard Starkings","role":"letterer"},{"name":"Saida Temofonte","role":"letterer"},{"name":"Greg Capullo","role":"penciller"},{"name":"Brian Haberlin","role":"colorist"},{"name":"Dan Kemp","role":"colorist"},{"name":"Avalon Studio","role":"colorist"},{"name":"Danny K. Miki","role":"inker"},{"name":"Tim Townsend","role":"inker"},{"name":"Grant Morrison","role":"writer"},{"name":"Ron Zimmerman","role":"writer"},{"name":"Frank Quitely","role":"penciller (cover)"}]
14946	http://i.annihil.us/u/prod/marvel/i/mg/7/10/577d1e5e3289c/detail.jpg	New X-Men (2001) #127	A riot has broken out in Mutant Town! Xorn, Cyclops, and Phoenix head out to quell the violence. But will the task of battling an anti-mutant mob prove more difficult than the X-Men had previously imagined?	2002-08-01	[{"name":"John Paul Leon","role":"penciller"},{"name":"Mike Marts","role":"editor"},{"name":"Grant Morrison","role":"writer"},{"name":"Frank Quitely","role":"penciller (cover)"},{"name":"Bill Sienkiewicz","role":"inker"}]
14947	http://i.annihil.us/u/prod/marvel/i/mg/7/00/577d25a808cf7/detail.jpg	New X-Men (2001) #128	Fantomex makes his glorious debut! Professor X has established an X-Corp office in Paris for mutants in need. Meanwhile, the overseas X-Men team undertakes their first mission after a distress signal is sent out from deep within the Channel Tunnel.	2002-08-15	[{"name":"Igor Kordey","role":"penciller"},{"name":"Mike Marts","role":"editor"},{"name":"Dave Mccaig","role":"colorist"},{"name":"Grant Morrison","role":"writer"},{"name":"Ethan Van Sciver","role":"penciller (cover)"},{"name":"Richard Starkings","role":"letterer"},{"name":"Saida Temofonte","role":"letterer"},{"name":"Tim Townsend","role":"inker"}]
14948	http://i.annihil.us/u/prod/marvel/i/mg/a/30/577d3a18aef99/detail.jpg	New X-Men (2001) #129	Despite international pressure, Professor X and Phoenix help to affect Fantomex's escape. Once clear of trouble, Fantomex makes not one, but two offers the mutant telepaths may not be able to refuse...	2002-09-01	[{"name":"Igor Kordey","role":"penciller (cover)"},{"name":"Mike Marts","role":"editor"},{"name":"Dave Mccaig","role":"colorist"},{"name":"Grant Morrison","role":"writer"},{"name":"Richard Starkings","role":"letterer"},{"name":"Saida Temofonte","role":"letterer"}]
14953	http://i.annihil.us/u/prod/marvel/i/mg/9/80/4c35ed2920f8d/detail.jpg	New X-Men (2001) #134	At the scene of a grisly murder, Cyclops and Beast discover an inhaler containing the drug Hypercortisone D, a mutant steroid. Who's pushing these drugs to young mutants? What will this mean for students back at the mansion?	2003-01-01	[{"name":"Kia Asamiya","role":"penciller"},{"name":"Keron Grant","role":"penciller"},{"name":"Chuck Austen","role":"writer"},{"name":"Stan Lee","role":"writer"},{"name":"Grant Morrison","role":"writer"},{"name":"Chris Chuckry","role":"colorist"},{"name":"J. D. Smith","role":"colorist"},{"name":"Mike Marts","role":"editor"},{"name":"Norm Rapmund","role":"inker"},{"name":"Ethan Van Sciver","role":"penciller (cover)"},{"name":"Richard Starkings","role":"letterer"},{"name":"Saida Temofonte","role":"letterer"},{"name":"Paul Tutrone","role":"letterer"}]
14954	http://i.annihil.us/u/prod/marvel/i/mg/7/00/577d5caf71809/detail.jpg	New X-Men (2001) #135	Xorn has taken the special class into the woods for a lesson they won't soon forget. Meanwhile, Quentin Quire assembles his fellow revolutionaries and gives them a little kick, in the form of some Hypercortisone D! Here come the New X-Men!	2003-02-01	[{"name":"Chris Chuckry","role":"colorist"},{"name":"Mike Marts","role":"editor"},{"name":"Grant Morrison","role":"writer"},{"name":"Frank Quitely","role":"penciller (cover)"},{"name":"Richard Starkings","role":"letterer"},{"name":"Saida Temofonte","role":"letterer"},{"name":"Tim Townsend","role":"inker"}]
14960	http://i.annihil.us/u/prod/marvel/i/mg/4/80/5968d6c6076b9/detail.jpg	New X-Men (2001) #141	MURDER AT THE MANSION PART 3 Sage's computer brain has been shut down! Beak takes responsibility for the murder of Emma Frost! But not everything is as it seems! Who is the real assassin?	2003-07-01	[{"name":"Phil Jimenez","role":"penciller (cover)"},{"name":"Grant Morrison","role":"writer"}]
123	http://i.annihil.us/u/prod/marvel/i/mg/d/10/577e6cfba4e76/detail.jpg	New X-Men (2001) #150	PLANET X FINALE Professor X and his X-Men make their final stand against Magneto, who was hiding under their noses disguised as team member Xorn for months. A beloved member of the X-Men will fall in this issue!	2003-12-17	[{"name":"Andy Lanning","role":"inker"},{"name":"Grant Morrison","role":"writer"}]
120	http://i.annihil.us/u/prod/marvel/i/mg/4/d0/577e91893fa78/detail.jpg	New X-Men (2001) #153	HERE COMES TOMORROW PART 3 Xavier's dream stays alive as the X-Men of tomorrow make preparations for a final showdown with...Beast!?	2004-02-18	[{"name":"Grant Morrison","role":"writer"},{"name":"Marc Silvestri","role":"penciller (cover)"}]
17412	http://i.annihil.us/u/prod/marvel/i/mg/4/b0/5c98f92c67934/detail.jpg	Howard the Duck (2007) #3	WHY is Howard in prison? WHEN did Beverly become more famous than Paris Hilton? WILL the evil scientists of A.I.M. succeed in destroying all TV and RADIO before America tunes in for the verdict in the sensational trial of Howard the Duck? And WHAT is Howard's never-before-seen duck-based SUPER-POWER? Guest starring the Sensational She-Hulk! HOW does Marvel pack THIS much into ONE comic?\r<br>Rated A ...$2.99 \r<br>	2007-12-05	[{"name":"Juan Bobillo","role":"penciller (cover)"},{"name":"Nestor Pereyra","role":"colorist"},{"name":"Nate Piekos","role":"letterer"},{"name":"Marcelo Sosa","role":"inker"},{"name":"Ty Templeton","role":"writer"}]
17278	http://i.annihil.us/u/prod/marvel/i/mg/3/f0/5c98ee0335196/detail.jpg	Howard the Duck (2007) #2	Forget Howard the Duck...this is Howard the SUPER-STAR!   Howard's latest short film becomes the internet's newest viral video phenomenon, and suddenly EVERYBODY wants to shoot at America's favorite angry duck.  But only SOME of them are aiming cameras. And what is A.I.M.'s part in all this, and is Beverly FINALLY wearing clothes again?\r<br>Rated A ...$2.99\r<br>	2007-11-07	[{"name":"Juan Bobillo","role":"penciller (cover)"},{"name":"Nestor Pereyra","role":"colorist"},{"name":"Nate Piekos","role":"letterer"},{"name":"Marcelo Sosa","role":"inker"},{"name":"Ty Templeton","role":"writer"}]
13170	http://i.annihil.us/u/prod/marvel/i/mg/8/c0/5ac62c27b7a13/detail.jpg	Fantastic Four (1961) #348	The new Fantastic Four's investigation has taken them all the way to Monster Island, home of the dreaded Mole Man.  Will they find out the truth about the slain FF...or another set of secrets entirely?	1991-02-28	[{"name":"Ralph Macchio","role":"editor"},{"name":"Bill Oakley","role":"colorist"},{"name":"Walter Simonson","role":"writer"},{"name":"Gracine Tanaka","role":"penciller"},{"name":"Art Thibert","role":"inker"}]
13080	http://i.annihil.us/u/prod/marvel/i/mg/d/10/58939fbc5aef2/detail.jpg	Fantastic Four (1961) #267		1984-06-10	[{"name":"Bob Budiansky","role":"editor"},{"name":"Michael Higgins","role":"letterer"},{"name":"Glynis Oliver","role":"colorist"}]
14949	http://i.annihil.us/u/prod/marvel/i/mg/c/90/4c35ed42cf97a/detail.jpg	New X-Men (2001) #130	The Paris X-Corp strike team fight for their lives in the Channel Tunnel against the being known only as Weapon XII! Plus, Fantomex's secrets are revealed!	2002-10-01	[{"name":"Chris Chuckry","role":"colorist"},{"name":"Dave Mccaig","role":"colorist"},{"name":"Igor Kordey","role":"penciller"},{"name":"Mike Marts","role":"editor"},{"name":"Grant Morrison","role":"writer"},{"name":"Ethan Van Sciver","role":"penciller (cover)"},{"name":"Richard Starkings","role":"letterer"},{"name":"Saida Temofonte","role":"letterer"}]
14955	http://i.annihil.us/u/prod/marvel/i/mg/2/90/577d5cceb4deb/detail.jpg	New X-Men (2001) #136	A U-Men squad attack Xorn and the special class in the woods outside the mansion! Meanwhile, Quentin Quire starts a riot at the institute! Plus, Cyclops and a certain woman who isn't his wife engage in a psychic tryst.	2003-03-01	[{"name":"Wes Abbot","role":"letterer"},{"name":"Richard Starkings","role":"letterer"},{"name":"Chris Chuckry","role":"colorist"},{"name":"Mike Marts","role":"editor"},{"name":"Grant Morrison","role":"writer"},{"name":"Frank Quitely","role":"penciller (cover)"},{"name":"Avalon Studio","role":"inker"}]
14958	http://i.annihil.us/u/prod/marvel/i/mg/4/b0/577d723e96f94/detail.jpg	New X-Men (2001) #139	MURDER AT THE MANSION PART 1 A psychic confrontation leads to Emma Frost shattered and broken in her diamond form! Has Jean Grey murdered her husband's would-be mistress?	2003-06-01	[{"name":"Phil Jimenez","role":"penciller"},{"name":"Grant Morrison","role":"writer"}]
14961	http://i.annihil.us/u/prod/marvel/i/mg/9/c0/4bc46b237fe78/detail.jpg	New X-Men (2001) #142	ASSAULT ON WEAPON + PART 1 Cyclops has a few too many in the new Hellfire Club. Who's his ride home? None other than Fantomex, the mysterious French mutant mercenary and Wolverine!	2003-08-01	[{"name":"Chris Bachalo","role":"penciller"},{"name":"Grant Morrison","role":"writer"}]
14963	http://i.annihil.us/u/prod/marvel/i/mg/e/c0/4bb7250bf2fad/detail.jpg	New X-Men (2001) #144	ASSAULT ON WEAPON + PART 3 Cyclops, Fantomex, and Wolverine must contend with The World's defenses-Car Cops! But even if they succeed, will they be able to take down the rogue Weapon XV?	2003-09-10	[{"name":"Chris Bachalo","role":"penciller"},{"name":"Grant Morrison","role":"writer"},{"name":"Tim Townsend","role":"inker"}]
121	http://i.annihil.us/u/prod/marvel/i/mg/c/90/577e7b19dbca3/detail.jpg	New X-Men (2001) #152	HERE COMES TOMORROW PART 2 Apollyon the Destroyer has brought the endless armies of the Beast to the Starlit Island! Will the X-Men give up the Phoenix egg?	2004-01-21	[{"name":"Grant Morrison","role":"writer"},{"name":"Marc Silvestri","role":"penciller (cover)"}]
21096	http://i.annihil.us/u/prod/marvel/i/mg/c/d0/4bb825ed7ee74/detail.jpg	Howard the Duck (1976) #1		1976-01-10	[{"name":"Frank Brunner","role":"penciller (cover)"},{"name":"John Costanza","role":"letterer"},{"name":"Steve Gerber","role":"writer"},{"name":"Steve Leialoha","role":"inker"},{"name":"Marv Wolfman","role":"editor"}]
16082	http://i.annihil.us/u/prod/marvel/i/mg/5/90/5ab50db562026/detail.jpg	Fantastic Four: 1234 (2001) #2	"Staring At The Fish Tank" Ben Grimm has been transformed and badly wounded. It is rumored that Prince Namor is massing forces at the outskirts of American waters. And Johnny must engage a powerful foe. With Reed still in isolation, who can help?	2001-11-10	[{"name":"Comicraft","role":"letterer"},{"name":"Richard Starkings","role":"letterer"},{"name":"Nanci Dakesian","role":"editor"},{"name":"Kelly Lamy","role":"editor"},{"name":"Stuart Moore","role":"editor"},{"name":"Jae Lee","role":"penciler"},{"name":"Grant Morrison","role":"writer"},{"name":"Jose Villarrubia","role":"colorist"}]
13073	http://i.annihil.us/u/prod/marvel/i/mg/1/20/5ac28b2aabdb0/detail.jpg	Fantastic Four (1961) #260		1983-11-10	[{"name":"Bob Budiansky","role":"editor"},{"name":"John Byrne","role":"penciller (cover)"},{"name":"Jim Novak","role":"letterer"},{"name":"Glynis Wein","role":"colorist"}]
14950	http://i.annihil.us/u/prod/marvel/i/mg/3/60/577d40205b9f2/detail.jpg	New X-Men (2001) #131	Romance is brewing among the X-Men! In Westchester, Warren takes the flight-capable students for a training session. There, sparks fly between Angel and Beak. Meanwhile, Scott and Emma engage in a rather unconventional therapy session...	2002-10-15	[{"name":"Chris Chuckry","role":"colorist"},{"name":"John Paul Leon","role":"penciller"},{"name":"Mike Marts","role":"editor"},{"name":"Grant Morrison","role":"writer"},{"name":"Ethan Van Sciver","role":"penciller (cover)"},{"name":"Bill Sienkiewicz","role":"inker"},{"name":"Richard Starkings","role":"letterer"},{"name":"Saida Temofonte","role":"letterer"}]
14952	http://i.annihil.us/u/prod/marvel/i/mg/f/a0/4c35ed2edae79/detail.jpg	New X-Men (2001) #133	Wolverine rescues a young mutant from an Afghani mutant slave ring and encounters Fantomex. What is the mysterious Frenchman up to this time? Meanwhile, Professor Xavier is made the target of a daring assassination attempt.	2002-12-01	[{"name":"Chris Chuckry","role":"colorist"},{"name":"Mike Marts","role":"editor"},{"name":"Grant Morrison","role":"writer"},{"name":"Frank Quitely","role":"penciller (cover)"},{"name":"Norm Rapmund","role":"inker"},{"name":"Ethan Van Sciver","role":"penciller"},{"name":"Richard Starkings","role":"letterer"},{"name":"Saida Temofonte","role":"letterer"}]
14957	http://i.annihil.us/u/prod/marvel/i/mg/8/03/577d6c7191401/detail.jpg	New X-Men (2001) #138	Cyclops, Xorn, and Beast set out to neutralize the flaming Glob Herman before he demolishes a busload of human children! Plus, a funeral for a mutant and the fate of Quentin Quire, aka Kid Omega, is revealed.	2003-05-01	[{"name":"Chris Chuckry","role":"colorist"},{"name":"Albert Deschesne","role":"letterer"},{"name":"Richard Starkings","role":"letterer"},{"name":"Stan Lee","role":"writer"},{"name":"Grant Morrison","role":"writer"},{"name":"Mike Marts","role":"editor"},{"name":"Frank Quitely","role":"penciller (cover)"},{"name":"Avalon Studio","role":"inker"}]
136	http://i.annihil.us/u/prod/marvel/i/mg/3/80/577e61629d0c0/detail.jpg	New X-Men (2001) #148	PLANET X PART 3 Manhattan is now New Genosha! While, Magneto prepares an agenda for a world without the X-Men, Jean and Logan hurtle toward the sun!	2003-10-15	[{"name":"Andy Lanning","role":"inker"},{"name":"Grant Morrison","role":"writer"}]
125	http://i.annihil.us/u/prod/marvel/i/mg/3/e0/577d6c820980b/detail.jpg	New X-Men (2001) #147	PLANET X PART 2 Witness the aftermath of Wolverine and Cyclops' adventure to Weapon Plus!	2003-10-08	[{"name":"Phil Jimenez","role":"penciller (cover)"},{"name":"Andy Lanning","role":"inker"},{"name":"Grant Morrison","role":"writer"}]
122	http://i.annihil.us/u/prod/marvel/i/mg/6/f0/577e75c614e3d/detail.jpg	New X-Men (2001) #151	HERE COMES TOMORROW PART 1 Society has crumbled, the human race is all but decimated, and mutants have evolved. But throughout the years, the dream of one man long dead still remains true - that of Professor Charles Xavier, that of the X-Men!	2004-01-07	[{"name":"Grant Morrison","role":"writer"},{"name":"Marc Silvestri","role":"penciller (cover)"}]
21103	http://i.annihil.us/u/prod/marvel/i/mg/6/d0/4bb5e6924666c/detail.jpg	Howard the Duck (1976) #16		1977-09-10	[{"name":"Terry Austin","role":"inker"},{"name":"Klaus Janson","role":"inker"},{"name":"Tom Palmer","role":"inker"},{"name":"John Buscema","role":"penciler"},{"name":"Dave Cockrum","role":"penciler"},{"name":"Gene Colan","role":"penciler"},{"name":"Dick Giordano","role":"penciler"},{"name":"Ed Hannigan","role":"penciler"},{"name":"Al Milgrom","role":"penciler"},{"name":"Mike Nasser","role":"penciler"},{"name":"Marie Severin","role":"penciler"},{"name":"Alan Weiss","role":"penciler"},{"name":"Steve Gerber","role":"editor"},{"name":"Doc Martin","role":"colorist"},{"name":"Irving Watanabe","role":"letterer"}]
48631	http://i.annihil.us/u/prod/marvel/i/mg/6/e0/52d6f0d66b686/detail.jpg	FF (2012) #16	The final showdown. The last FF member standing, Scott Lang goes up against Dr. Doom alone -- and everyone knows the Ant can&#39;t. The smackdown of the century. Plus an extra ten page bonus of F4/FF goodness co-written by Karl Kesel and the Allreds.	2014-01-22	[{"name":"Lee Allred","role":"writer"},{"name":"Matt Fraction","role":"writer"},{"name":"Mike Allred","role":"penciller (cover)"}]
38696	http://i.annihil.us/u/prod/marvel/i/mg/9/50/5a9ecfb933006/detail.jpg	Ultimate Comics Ultimates  (2011) #9	With S.H.I.E.L.D. taken over, what does the future of the Ultimates hold? With nations falling, will the Ultimates be able to stand against this new threat before it brings the U.S. to its knees?\n	2012-04-25	[{"name":"FIRM 15","role":"Writer"},{"name":"Kaare Andrews","role":"painter (cover)"},{"name":"Virtual Calligr","role":"Letterer"},{"name":"Vc Clayton Cowles","role":"letterer"},{"name":"Jonathan Hickman","role":"writer"},{"name":"Esad Ribic","role":"artist"},{"name":"Dean White","role":"colorist"}]
37399	http://i.annihil.us/u/prod/marvel/i/mg/a/20/57e976329adaf/detail.jpg	Fantastic Four (1998) #600	FOREVER PART 1 The 50th anniversary issue of the Fantastic Four! Joins us for the epic celebration of Marvel's First Family with 96 pages of all-new content!	2011-11-23	[{"name":"FIRM 15","role":"Writer"}]
16081	http://i.annihil.us/u/prod/marvel/i/mg/5/d0/5ab502572a7d3/detail.jpg	Fantastic Four: 1234 (2001) #1	"Once Upon a Time On Yancy Street" When Reed Richards has the "Deep In Thought" sign up, the rest of the FF know not to bother him. But the heat is rising in Manhattan and a Doombot has just gone active. A sinister game is afoot!	2001-10-01	[{"name":"Wes Abbot","role":"letterer"},{"name":"Richard Starkings","role":"letterer"},{"name":"Nanci Dakesian","role":"editor"},{"name":"Kelly Lamy","role":"editor"},{"name":"Stuart Moore","role":"editor"},{"name":"Jae Lee","role":"penciler"},{"name":"Grant Morrison","role":"writer"},{"name":"Jose Villarrubia","role":"colorist"}]
13171	http://i.annihil.us/u/prod/marvel/i/mg/6/80/5ac6339f6750a/detail.jpg	Fantastic Four (1961) #349	A Skrull stands revealed underneath Monster Island! But what has roped the new Fantastic Four and the entire Skrull army into a confrontation within the Mole Man's secret lair?	1991-02-01	[{"name":"Arthur Adams","role":"penciler"},{"name":"Steve Buccellato","role":"colorist"},{"name":"Ralph Macchio","role":"editor"},{"name":"Al Milgrom","role":"inker"},{"name":"Art Thibert","role":"inker"},{"name":"Bill Oakley","role":"letterer"},{"name":"Walter Simonson","role":"writer"},{"name":"Gracine Tanaka","role":"penciller"}]
14951	http://i.annihil.us/u/prod/marvel/i/mg/9/70/4c35ed38e05b7/detail.jpg	New X-Men (2001) #132	The X-Men are on Genosha, surveying the destruction of the former mutant city, when they encounter Polaris. The X-Men attempt to calm the confused mutant when they inadvertently activate a recorded message from the deceased Magneto...	2002-11-01	[{"name":"Jimmy Betancourt","role":"letterer"},{"name":"Richard Starkings","role":"letterer"},{"name":"Chris Chuckry","role":"colorist"},{"name":"Andy Lanning","role":"inker"},{"name":"Mike Marts","role":"editor"},{"name":"Grant Morrison","role":"writer"},{"name":"Frank Quitely","role":"penciller (cover)"}]
14956	http://i.annihil.us/u/prod/marvel/i/mg/9/b0/577d62c5c9c3a/detail.jpg	New X-Men (2001) #137	Glob Herman has learned a new way to use his power: Glob-napalm! With flaming goo raining from above, Quentin Quire faces the newly freed Professor. Who will take the school? Plus, the mystery of Jumbo Carnation's death is revealed!	2003-04-01	[{"name":"Jimmy Betancourt","role":"letterer"},{"name":"Richard Starkings","role":"letterer"},{"name":"Chris Chuckry","role":"colorist"},{"name":"Mike Marts","role":"editor"},{"name":"Grant Morrison","role":"writer"},{"name":"Frank Quitely","role":"penciller (cover)"},{"name":"J. D. Smith","role":"inker"},{"name":"Avalon Studio","role":"inker"}]
21126	http://i.annihil.us/u/prod/marvel/i/mg/1/e0/4bb5ea6db6d3a/detail.jpg	Howard the Duck (1976) #9		1977-02-10	[{"name":"Gene Colan","role":"penciller (cover)"},{"name":"John Costanza","role":"letterer"},{"name":"Steve Gerber","role":"editor"},{"name":"Steve Leialoha","role":"inker"},{"name":"Michele Wolfman","role":"colorist"}]
21125	http://i.annihil.us/u/prod/marvel/i/mg/f/80/4bb5ea72d4ef8/detail.jpg	Howard the Duck (1976) #8		1977-01-10	[{"name":"Janice Cohen","role":"colorist"},{"name":"Gene Colan","role":"penciller (cover)"},{"name":"Steve Gerber","role":"writer"},{"name":"David Anthony Kraft","role":"writer"},{"name":"Don Mcgregor","role":"writer"},{"name":"Archie Goodwin","role":"editor"},{"name":"Steve Leialoha","role":"inker"},{"name":"Irving Watanabe","role":"letterer"}]
17649	http://i.annihil.us/u/prod/marvel/i/mg/7/50/5c98f9e5c1671/detail.jpg	Howard the Duck (2007) #4	This is it!  The final showdown between Howard the Duck and the evil forces bent on controlling America. Will Howard and Bev survive being crucified by the media? PLUS: Howard gets his greatest wish granted, by the most powerful man in the free world! (Can you guess who it is?)\r<br>32 PGS./Rated A ...$2.99 \r<br>	2008-01-04	[{"name":"Juan Bobillo","role":"penciller (cover)"},{"name":"Nestor Pereyra","role":"colorist"},{"name":"Nate Piekos","role":"letterer"},{"name":"Marcelo Sosa","role":"inker"},{"name":"Ty Templeton","role":"writer"}]
16084	http://i.annihil.us/u/prod/marvel/i/mg/8/70/5ab52762cb0a2/detail.jpg	Fantastic Four: 1234 (2001) #4	"Prime Mover" Learn the terrible history of Reed Richards and see Doom's plan revealed in all its horrible glory. Prepare for a game of robot annihilator chess on the planes of reality and the great metaphysical beyond!	2002-01-10	[{"name":"Wes Abbot","role":"letterer"},{"name":"Nanci Dakesian","role":"editor"},{"name":"Kelly Lamy","role":"editor"},{"name":"Stuart Moore","role":"editor"},{"name":"Bronwyn Taggart","role":"editor"},{"name":"Jae Lee","role":"penciler"},{"name":"Grant Morrison","role":"writer"},{"name":"Jose Villarrubia","role":"colorist"}]
16083	http://i.annihil.us/u/prod/marvel/i/mg/6/70/5ab51b1c28789/detail.jpg	Fantastic Four: 1234 (2001) #3	"Darkness & The Mole Man" Doom has crushed another member of the Four. Alicia is trapped in the subterranean caverns of the Mole Man, with only Johnny Storm to save her. But Namor has extinguished the Human Torch-can Storm still summon the flame?!	2001-12-26	[{"name":"Nanci Dakesian","role":"editor"},{"name":"Kelly Lamy","role":"editor"},{"name":"Steve Moore","role":"editor"},{"name":"Stuart Moore","role":"editor"},{"name":"Jae Lee","role":"artist"},{"name":"Grant Morrison","role":"writer"},{"name":"Richard Starkings","role":"letterer"},{"name":"Jose Villarrubia","role":"colorist"}]
13169	http://i.annihil.us/u/prod/marvel/i/mg/3/00/4bc479234b700/detail.jpg	Fantastic Four (1961) #347	The Fantastic Four are dead!  Long live the new Fantastic Four - Spider-Man, Wolverine, Hulk, and Ghost Rider!? Can they get to the bottom of the FF's demise? And just what do the Skrulls want with this new team?	1991-02-10	[{"name":"Ralph Macchio","role":"editor"},{"name":"Bill Oakley","role":"letterer"},{"name":"Walter Simonson","role":"writer"},{"name":"Art Thibert","role":"inker"}]
13074	http://i.annihil.us/u/prod/marvel/i/mg/9/80/5abd3f4d57275/detail.jpg	Fantastic Four (1961) #261		1983-12-10	[]
13071	http://i.annihil.us/u/prod/marvel/i/mg/6/a0/5ac282674ac96/detail.jpg	Fantastic Four (1961) #259		1983-10-10	[{"name":"Bob Budiansky","role":"editor"},{"name":"John Byrne","role":"penciller (cover)"},{"name":"Jim Novak","role":"letterer"},{"name":"Glynis Wein","role":"colorist"}]
14959	http://i.annihil.us/u/prod/marvel/i/mg/a/03/577e51b651346/detail.jpg	New X-Men (2001) #140	MURDER AT THE MANSION PART 2 Sage and Bishop are called in to investigate Emma Frost's murder. Who are the suspects? Where's the murder weapon? And what does this all have to do with Hypercortisone D-the mutant stimulant known as Kick?	2003-06-30	[{"name":"Phil Jimenez","role":"penciller"},{"name":"Grant Morrison","role":"writer"}]
124	http://i.annihil.us/u/prod/marvel/i/mg/7/10/577e6760e25cf/detail.jpg	New X-Men (2001) #149	PLANET X PART 4 Magneto rules supreme! The humans are all but exterminated in Manhattan! Can anyone stop the powered-up Master of Magnetism? Cyclops and his X-Men aim to try!	2003-11-19	[{"name":"Andy Lanning","role":"inker"},{"name":"Grant Morrison","role":"writer"}]
14962	http://i.annihil.us/u/prod/marvel/i/mg/b/b0/4bb7251aef31c/detail.jpg	New X-Men (2001) #143	ASSAULT ON WEAPON + PART 1 Cyclops has a few too many in the new Hellfire Club. Who's his ride home? None other than Fantomex, the mysterious French mutant mercenary and Wolverine!	2003-08-30	[{"name":"Chris Bachalo","role":"penciller"},{"name":"Grant Morrison","role":"writer"},{"name":"Tim Townsend","role":"inker"}]
420	http://i.annihil.us/u/prod/marvel/i/mg/a/b0/577e97dec47f5/detail.jpg	New X-Men (2001) #154	HERE COMES TOMORROW PART 4 It all comes down to this. Two groups of X-Men from different eras will decide the fate of mutantkind!	2004-03-17	[{"name":"Grant Morrison","role":"writer"},{"name":"Marc Silvestri","role":"penciller (cover)"}]
16582	http://i.annihil.us/u/prod/marvel/i/mg/a/20/5c98e652af3e7/detail.jpg	Howard the Duck (2007) #1	Grab your guns and camcorders and start shooting, it's DUCK SEASON!  Marvel's favorite furious fowl, Howard, and his faithful friend with benefits, Beverly, begin their journey to destroy the internet, radio and television, in this all new mini-series by Ty (She-Hulk) Templeton and Juan (She-Hulk) Bobillo. SEE Howard face mighty hunters with mighty guns on MeTube!  SEE Beverly in nothing but fig leaves!  SEE grown men dressed as bunnies! And who is that giant headed guy taking A.I.M. at our heroes? HINT:  It starts with "MODO-" Just when you thought it was safe to read comics again...and Marvel has to do THIS?!?\r<br>32 PGS./Rated A ...$2.99\r<br>	2007-10-03	[{"name":"Juan Bobillo","role":"penciller (cover)"},{"name":"Nestor Pereyra","role":"colorist"},{"name":"Nate Piekos","role":"letterer"},{"name":"Marcelo Sosa","role":"inker"},{"name":"Ty Templeton","role":"writer"}]
13257	http://i.annihil.us/u/prod/marvel/i/mg/6/b0/5372d7ee490d3/detail.jpg	Fantastic Four (1961) #51		1966-06-10	[{"name":"Jack Kirby","role":"penciller (cover)"},{"name":"Stan Lee","role":"editor"},{"name":"Artie Simek","role":"letterer"},{"name":"Joe Sinnott","role":"inker"}]
13070	http://i.annihil.us/u/prod/marvel/i/mg/e/a0/5ac27a1e4fa0e/detail.jpg	Fantastic Four (1961) #258		1983-09-10	[{"name":"John Byrne","role":"penciller (cover)"},{"name":"Jim Novak","role":"letterer"},{"name":"Carl Potts","role":"editor"},{"name":"Glynis Wein","role":"colorist"}]
13069	http://i.annihil.us/u/prod/marvel/i/mg/6/30/5ac2709a47e60/detail.jpg	Fantastic Four (1961) #257		1983-08-10	[{"name":"John Byrne","role":"penciller (cover)"},{"name":"Al Milgrom","role":"editor"},{"name":"Jim Novak","role":"letterer"},{"name":"Glynis Oliver","role":"colorist"}]
13067	http://i.annihil.us/u/prod/marvel/i/mg/2/03/5ac2464318660/detail.jpg	Fantastic Four (1961) #255		1983-06-10	[{"name":"John Byrne","role":"penciller (cover)"},{"name":"Al Milgrom","role":"editor"},{"name":"Jim Novak","role":"letterer"},{"name":"Glynis Oliver","role":"colorist"}]
13066	http://i.annihil.us/u/prod/marvel/i/mg/c/a0/5ac239e258fdd/detail.jpg	Fantastic Four (1961) #254		1983-05-10	[{"name":"John Byrne","role":"writer"},{"name":"Al Milgrom","role":"editor"},{"name":"Jim Novak","role":"letterer"},{"name":"Glynis Oliver","role":"colorist"}]
13065	http://i.annihil.us/u/prod/marvel/i/mg/2/20/5ac2300b01187/detail.jpg	Fantastic Four (1961) #253		1983-04-10	[{"name":"John Byrne","role":"penciller (cover)"},{"name":"Al Milgrom","role":"editor"},{"name":"Jim Novak","role":"letterer"},{"name":"Glynis Oliver","role":"colorist"}]
13064	http://i.annihil.us/u/prod/marvel/i/mg/b/a0/5ac222fa1eb38/detail.jpg	Fantastic Four (1961) #252		1983-03-10	[{"name":"John Byrne","role":"penciller (cover)"},{"name":"Tom Defalco","role":"editor"},{"name":"Jim Novak","role":"letterer"},{"name":"Glynis Oliver","role":"colorist"}]
13055	http://i.annihil.us/u/prod/marvel/i/mg/8/f0/5abd473c721d3/detail.jpg	Fantastic Four (1961) #244		1982-07-10	[{"name":"John Byrne","role":"penciller (cover)"},{"name":"Jim Novak","role":"letterer"},{"name":"Jim Salicrup","role":"editor"},{"name":"Jim Shooter","role":"editor"},{"name":"Glynis Wein","role":"colorist"}]
13054	http://i.annihil.us/u/prod/marvel/i/mg/5/20/5abd2fcad8ac9/detail.jpg	Fantastic Four (1961) #243		1982-06-10	[{"name":"John Byrne","role":"penciller (cover)"},{"name":"Jim Novak","role":"letterer"},{"name":"Jim Salicrup","role":"editor"},{"name":"Jim Shooter","role":"editor"},{"name":"Glynis Wein","role":"colorist"}]
13053	http://i.annihil.us/u/prod/marvel/i/mg/3/50/5abd179519431/detail.jpg	Fantastic Four (1961) #242		1982-05-10	[{"name":"John Byrne","role":"penciller (cover)"},{"name":"Jim Novak","role":"letterer"},{"name":"Jim Salicrup","role":"editor"},{"name":"Jim Shooter","role":"editor"},{"name":"Glynis Wein","role":"colorist"}]
4445	http://i.annihil.us/u/prod/marvel/i/mg/9/60/5a95bd6d1b482/detail.jpg	Ultimate Fantastic Four (2003) #32	FRIGHTFUL CONCLUSION The Ultimate Fantastic Four versus the Zombie Universe Fantastic Four!	2006-08-16	[{"name":"Vc Randy Gentile","role":"letterer"},{"name":"Greg Land","role":"penciller (cover)"},{"name":"Mark Millar","role":"writer"},{"name":"Justin Ponsor","role":"colorist"},{"name":"Matt Ryan","role":"inker"}]
4290	http://i.annihil.us/u/prod/marvel/i/mg/4/80/5a95b8736775f/detail.jpg	Ultimate Fantastic Four (2003) #31	FRIGHTFUL PART 2 The zombified Fantastic Four break free! Plus, an alien object Johnny brought back from the N-Zone begins to grow and will soon consume every living thing on Earth. Only man on Earth can stop it. And that man is Doctor Doom!	2006-07-12	[{"name":"Vc Randy Gentile","role":"letterer"},{"name":"Greg Land","role":"penciller (cover)"},{"name":"Mark Millar","role":"writer"},{"name":"Justin Ponsor","role":"colorist"},{"name":"Matt Ryan","role":"inker"}]
4145	http://i.annihil.us/u/prod/marvel/i/mg/9/e0/5a96d88b5ce23/detail.jpg	Ultimate Fantastic Four (2003) #30	FRIGHTFUL PART 1 The awesome return of Dr. Doom! The zombiefied F.F. escape from their Baxter Building prison! The deadly debut of the Frightful Four! Johnny Storm finds out he has only 28 days to live!	2006-05-31	[{"name":"Mitch Breitweiser","role":"artist"},{"name":"Vc Randy Gentile","role":"letterer"},{"name":"Greg Land","role":"penciller (cover)"},{"name":"Mark Millar","role":"writer"},{"name":"Justin Ponsor","role":"colorist"},{"name":"Matt Ryan","role":"inker"}]
2412	http://i.annihil.us/u/prod/marvel/i/mg/6/e0/5a9476f64d4e0/detail.jpg	Ultimate Fantastic Four (2003) #23	CROSSOVER PART 3 The Fantastic Four must join forces with one of their world's greatest villains to survive an epic battle on an alternate Earth against the Marvel Zombies!	2005-09-21	[{"name":"Virtual Calligr","role":"letterer"},{"name":"Greg Land","role":"penciller (cover)"},{"name":"Mark Millar","role":"writer"},{"name":"Justin Ponsor","role":"colorist"},{"name":"Matt Ryan","role":"inker"}]
2303	http://i.annihil.us/u/prod/marvel/i/mg/3/70/5a947084e170c/detail.jpg	Ultimate Fantastic Four (2003) #22	CROSSOVER PART 2 The Fantastic Four are being pursued by the most unlikely of enemies on an alternate Earth - the Marvel Zombies. And the only ally they can turn to is...Magneto?	2005-08-10	[{"name":"Virtual Calligr","role":"letterer"},{"name":"Greg Land","role":"penciller"},{"name":"Mark Millar","role":"writer"},{"name":"Justin Ponsor","role":"colorist"},{"name":"Matt Ryan","role":"inker"}]
2183	http://i.annihil.us/u/prod/marvel/i/mg/4/50/5a946be953667/detail.jpg	Ultimate Fantastic Four (2003) #21	CROSSOVER PART 1 Reed Richards has found a way to travel to an alternate Earth in another dimension. Being the imaginauts they are, the Fantastic Four set out on a mission of ultimate discovery -but discover the Marvel Zombies.	2005-07-13	[{"name":"Virtual Calligr","role":"letterer"},{"name":"Dave Land","role":"artist"},{"name":"Greg Land","role":"penciller (cover)"},{"name":"Mark Millar","role":"writer"},{"name":"Justin Ponsor","role":"colorist"},{"name":"Matt Ryan","role":"inker"}]
1986	http://i.annihil.us/u/prod/marvel/i/mg/d/70/5c94dcafb9879/detail.jpg	Spider-Man/Human Torch (2005) #5	Peter Parker might be the coolest teacher in school, but how will he stack up to the guest-speaker at today's special assembly, the one-and-only Human Torch? And when a band of no-good crooks show up, will the duo be able to keep the students safe?	2005-06-29	[{"name":"Nelson Decastro","role":"inker"},{"name":"Dave Lanphear","role":"letterer"},{"name":"Dan Slott","role":"writer"},{"name":"Paul Smith","role":"penciller (cover)"},{"name":"Chris Sotomayor","role":"colorist"},{"name":"Ty Templeton","role":"penciller"}]
1592	http://i.annihil.us/u/prod/marvel/i/mg/6/40/5c93c234a6c36/detail.jpg	Spider-Man/Human Torch (2005) #1	See what happens when young Johnny Storm wants some of Spidey's front page exposure...and hires Peter Parker to be his personal photographer! This one has doom written all over it - Doctor Doom that is!	2005-01-05	[{"name":"Dan Slott","role":"writer"},{"name":"Ty Templeton","role":"penciller"}]
1885	http://i.annihil.us/u/prod/marvel/i/mg/6/80/5c93f2f85004d/detail.jpg	Spider-Man/Human Torch (2005) #4	In a love triangle that might end badly, the Torch puts the moves on the Black Cat! Is Johnny her squeez, or a cat's-paw for her latest heist? This one's got it all, spider-fan: the black costume, the Black Cat, and...wait for it...the Black Panther?!	2005-05-11	[{"name":"Nelson Decastro","role":"inker"},{"name":"Dave Lanphear","role":"letterer"},{"name":"Dan Slott","role":"writer"},{"name":"Paul Smith","role":"penciller (cover)"},{"name":"Chris Sotomayor","role":"colorist"},{"name":"Ty Templeton","role":"penciller"}]
1781	http://i.annihil.us/u/prod/marvel/i/mg/9/c0/5c93e8d591da2/detail.jpg	Spider-Man/Human Torch (2005) #3	Two guys hanging out in the garage, building a car from scratch. Sounds like your typical male-bonding experience, right? Well, not when they're putting together a Spider-Mobile! For the love of all that's holy--get off the streets, the walls too! 	2005-03-23	[{"name":"Nelson Decastro","role":"inker"},{"name":"Dan Slott","role":"writer"},{"name":"Paul Smith","role":"penciller (cover)"},{"name":"Avalon Studio","role":"colorist"},{"name":"Ty Templeton","role":"penciller"}]
860	http://i.annihil.us/u/prod/marvel/i/mg/c/20/51ed63ab9d42c/detail.jpg	Wolverine (2003) #20	"ENEMY OF THE STATE" PART 1 (OF 6) The world's deadliest living weapon just fell into the wrong hands. It's Wolverine vs. the Marvel Universe in a blockbuster storyline that will have Logan shredding his way through the X-Men, Avengers, Fantastic Four, and more!	2004-10-06	[{"name":"Klaus Janson","role":"inker"},{"name":"Mark Millar","role":"writer"},{"name":"Paul Mounts","role":"colorist"},{"name":"Rus Wooton","role":"letterer"}]
1681	http://i.annihil.us/u/prod/marvel/i/mg/a/00/5c93dd1895f0f/detail.jpg	Spider-Man/Human Torch (2005) #2	On a stupid dare, ol' web-head and hot-head trade places to see who's got it easier. Now the Human Torch has to track down Kraven the Hunter â€" while Spidey joins the rest of the Fantastic Four on a strange new cosmic adventure! 	2005-02-23	[{"name":"Dan Slott","role":"writer"},{"name":"Avalon Studio","role":"colorist"},{"name":"Ty Templeton","role":"penciller"}]
73423	http://i.annihil.us/u/prod/marvel/i/mg/c/50/5cacf6e71392a/detail.jpg	Guardians of the Galaxy (2019) #4	The Dark Guardians, a new cosmic hit squad made up of the most powerful and cunning people in space, are going to kill Gamora. It’s time for the new Guardians of the Galaxy to saddle up!\n	2019-04-17	[{"name":"Donny Cates","role":"writer"},{"name":"David Curiel","role":"colorist"},{"name":"David Marquez","role":"penciler (cover)"},{"name":"Vc Cory Petit","role":"letterer"},{"name":"Darren Shan","role":"editor"},{"name":"Geoffrey Shaw","role":"inker"},{"name":"Dean White","role":"colorist (cover)"}]
238	http://i.annihil.us/u/prod/marvel/i/mg/d/00/5baced808e697/detail.jpg	Ultimate X-Men (2000) #41	NEW MUTANTS PART 2 A deadly new mutant with a horrifying power debuts. And only one of Prof. X's X-Men has a chance-in-hell of stopping the carnage.	2004-01-14	[{"name":"Brian Michael Bendis","role":"writer"},{"name":"David Finch","role":"penciller (cover)"},{"name":"Art Thibert","role":"inker"}]
9151	http://i.annihil.us/u/prod/marvel/i/mg/6/80/5b8836640ec1d/detail.jpg	Incredible Hulk (1962) #340	After the Hulk accidentally destroys a plane, Wolverine is out to make him pay for his mistake. It's Wolverine vs. the Hulk!\n	1988-02-01	[{"name":"Peter David","role":"writer"},{"name":"Bob Harras","role":"editor"},{"name":"Todd Mcfarlane","role":"penciller (cover)"},{"name":"Rick Parker","role":"letterer"},{"name":"Petra Scotese","role":"colorist"},{"name":"Bob Wiacek","role":"inker"}]
\.


--
-- Data for Name: comic_collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comic_collection (comic_id, collection_id) FROM stdin;
6913	1
6869	1
6817	1
6738	1
6636	1
6508	1
1271	1
12028	1
24419	1
43137	1
72686	3
31425	3
29070	3
20933	3
19898	3
5872	3
5816	3
17198	4
52333	4
16088	4
15873	4
13061	4
12398	4
9111	4
8951	4
7174	4
365	4
44198	5
30581	5
15943	5
11708	5
11690	5
11681	5
11665	5
11482	5
11454	5
875	5
21650	6
21330	6
20852	6
20642	6
12168	6
10575	6
10155	6
14933	7
14934	7
14935	7
14936	7
14937	7
14938	7
14939	7
14940	7
14941	7
14942	7
14943	7
14944	7
14945	7
14946	7
14947	7
14948	7
14949	7
14950	7
14951	7
14952	7
14953	7
14954	7
14955	7
14956	7
14957	7
14958	7
14959	7
14960	7
14961	7
14962	7
14963	7
14964	7
14965	7
420	7
136	7
125	7
124	7
123	7
122	7
121	7
120	7
21126	8
21125	8
21103	8
21096	8
17649	8
17412	8
17278	8
16582	8
48631	9
38696	9
37399	9
16084	9
16083	9
16082	9
16081	9
13257	9
13171	9
13170	9
13169	9
13080	9
13074	9
13073	9
13071	9
13070	9
13069	9
13067	9
13066	9
13065	9
13064	9
13055	9
13054	9
13053	9
4445	9
4290	9
4145	9
2412	9
2303	9
2183	9
1986	9
1885	9
1781	9
1681	9
1592	9
238	6
860	6
9151	6
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, email, username, password, salt, role) FROM stdin;
1	peterparker@dailybugle.com	SpideyFan	FC8u8Xe/f8Kk+SXNcr0zIg==	fgeafMPUgGJrCYqLLa/Xe21Z3O0gHr9QIvWbxYE6v9V92I9EYBa0QiaZb91GnO4yDhF9nc9w8UJrRVcCRfwQVzS+bzXUhAcrgVZ0cPhfyRoOoKIilfgeUigdRP69B/DPq7F5ZlspMNYMugFfFiSZSlabDM0pE/MSWVLf2gM8vZ8=	standard
2	lajellison@gmail.com	xXxDragonSlayerxXx	b7l+bDYkt/t8c3kcVUcJYg==	Ng7E0wpTm7wZ9dT8w8mp71pPZ9HQsrR/X9u7ZPxTnYiMKQTelNLD0WEGw1VxBSLSTiEYaZk5BrfE/Fi2sqUUZAQ0Uk83qiusq6MJ//eDbnlYPY0at0dl6h4FRFpi9n1zYdY3j/wvJb9FXqHdsvI9rCRpy41kJoJ7mGtJ7vydLVc=	premium
3	t.stark@starkindustries.org	TonyStark	WLQZMpu3izuHSnvW+H745A==	4/mbpFo70CvMben56WqLrcfCUB63EAKHZdujAEhmcvhzYVSQJDdYMJASlKtHl2CG258VA37z/0nBwLSoputvId9QfT5/45VxzmFaVqom7pYQna5NA7IMoVuBkfmB4+ra+7pNobaULJotz4m3SnMx7ktbPcgFslHGjwf6zzkgM8s=	premium
4	gammaguy@aol.com	JoeFixit	oHZECMSVEnl2aSsI6J87eQ==	f5RbgwFhEX72qAW3rwVyX8wRxdjQMzIB6TGF0HtL5OHJrQEjcq5mB2mefTbe0ARmqmAGvA1FJlxTuRil+MaocuvmezASJEQDmpGKCniq13ooYayJgZGBO/t4U1jkR15qyb9p7qLIGampGtzzsEil1yA5L/FaS3JIpThJH6udw20=	standard
5	MjolnirMan@bifrost.net	ThorOdinson	qRGC9jVSJmM3WzF3DYns+g==	m3JiUXK9dIsX41hGTRJPTn/2duITKSGb4QZ6FZfYbFp+TmpEJYZ1YzgVWMlaVYEuYZdp38vtnrP3q73RMzK8nVAON2MZlAkpnsyZmuBNv9WC+Vy5RDH1CacquzQ5s92mkz5huVx75ur2puDAdrmMs0UxwkhT4CkbpqM+yM9yk1c=	standard
6	logan@hotmail.com	WeaponX	Akhq0pvvB56F62BPqJmoEg==	Ts0JUb4dWQfGRhcFHWUC7x+6iRKPqdnPvNscF8Db0BFbUZicCsGDRGQ8Jc8WTTXsB25UCGu17JR86/+L/W25PsxqqBylULgpNtrRcqSZ6PgZzlJdE+AcW5eVyQuLkwG18Un0fbmPeffbhifOGWuuQThHnD6H3kTobFBmDHFnOFg=	standard
7	jalbertson@gmail.com	ComicBookGuy	44Ya6vOu1o2LFO4sLeO+CQ==	T1ppvnRUKmZImLjAGqSfuS4ktD3IYA5jvwBlQ25jUI23JkdudUOFQ3GPX9p2GEQGwSgnJgwUrW1uclo+hqgQmq6SPotFC9hbj+whk9j0+R8NRj/iU3pHlzHjaRMWPYCF2LTl2DfA3xNZBm3hXYDpBAl7XMVjMYaaNsZgI/YvPjM=	premium
\.


--
-- Name: collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.collection_id_seq', 9, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 7, true);


--
-- Name: collections pk_collections_collection_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT pk_collections_collection_id PRIMARY KEY (collection_id);


--
-- Name: comic_collection pk_comic_collection_comic_id_collection_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comic_collection
    ADD CONSTRAINT pk_comic_collection_comic_id_collection_id PRIMARY KEY (comic_id, collection_id);


--
-- Name: comic pk_comic_comic_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comic
    ADD CONSTRAINT pk_comic_comic_id PRIMARY KEY (comic_id);


--
-- Name: users pk_users_user_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT pk_users_user_id PRIMARY KEY (user_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: collections collections_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.collections
    ADD CONSTRAINT collections_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: comic_collection comic_collection_collection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comic_collection
    ADD CONSTRAINT comic_collection_collection_id_fkey FOREIGN KEY (collection_id) REFERENCES public.collections(collection_id);


--
-- Name: comic_collection comic_collection_comic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comic_collection
    ADD CONSTRAINT comic_collection_comic_id_fkey FOREIGN KEY (comic_id) REFERENCES public.comic(comic_id);


--
-- PostgreSQL database dump complete
--

