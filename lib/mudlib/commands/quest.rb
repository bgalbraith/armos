# The quest command
# Displays the user's quest log
def action(user, args)
  text = <<EndText
////// Quests //////

  ==> (100%) Port Fleeting

     Lvl   Stat        Quest        ==> Booty
    [---] (DONE)      Marooned      ==> A little pocket change to get started
    [---] (DONE) Haunted Beginnings ==> Make some otherworldly friends
    [---] (DONE)   Capitalism, Ho   ==> Screw the poor, we've got more!
    [---] (DONE)  Lunar Astrolabe   ==> Moon Crystals?
    [---] (DONE)     Vacancies      ==> Unlock a new feature
    [001] (DONE)   Troubled Wench   ==> Marks and adventure!

  ==> (  0%) Whispering Ruins

     Lvl   Stat        Quest        ==> Booty
    [001] (----)  Wayward Husband   ==> Your very own ship!
EndText
  log = <<EndText
////// Haunted Beginnings //////

  ==> Requirements (100%)

    Quest ==> Marooned (DONE)

  ==> Precis
      Area ==> Port Fleeting     Booty ==> a purple moon crystal
     Level ==> Any                     ==> 15 doubloons
    Status ==> In Progress             ==> Capitalism, Ho (QUEST)

    There is a strange monument in the main plaza of Port Fleeting. Given your
    desperate situation, perhaps paying your respects to the spirits of dead
    skyfarers may help?

==> The Story So Far

    While paying your respects to the monument in Port Fleeting's main plaza,
    you met with ghosts of departed skyfarers. You came to an arrangement, and
    promptly blacked out, waking up at the inn. After that, you were prompted
    to try changing your partner with <<ghostswap>>.
EndText
  if args.nil?
    write("#{text}\n",user)
  else
    write("#{log}\n",user)
  end
end