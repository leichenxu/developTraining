package com.gramevapp.web.controller;

import com.gramevapp.web.model.Experiment;
import com.gramevapp.web.model.Grammar;
import com.gramevapp.web.model.User;
import com.gramevapp.web.repository.GrammarRepository;
import com.gramevapp.web.service.ExperimentService;
import com.gramevapp.web.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class GrammarController {

    @Autowired
    private UserService userService;


    @Autowired
    private GrammarRepository grammarRepository;


    @RequestMapping(value="/grammar/grammarRepository", method= RequestMethod.GET)
    public String grammarRepository(Model model){

        User user = userService.getLoggedInUser();
        if(user == null){
            System.out.println("User not authenticated");
            return "redirect:/login";
        }

        List<Grammar> grammarList = grammarRepository.findByUserId(user.getId());

        model.addAttribute("grammarList", grammarList);
        model.addAttribute("user", user);

        return "grammar/grammarRepository";
    }


    @RequestMapping(value="/grammar/grammarRepoSelected", method=RequestMethod.POST, params="deleteGrammar")
    public
    @ResponseBody
    Long expRepoSelectedDelete(@RequestParam("grammarId") String grammarId){
        Long idGrammar = Long.parseLong(grammarId);

        grammarRepository.deleteById(idGrammar);

        return idGrammar;
    }


    @RequestMapping(value="/grammar/grammarDetail", method= RequestMethod.POST)
    public String editGrammar(Model model, @RequestParam("grammarId") String grammarId){

        User user = userService.getLoggedInUser();
        if(user == null){
            System.out.println("User not authenticated");
            return "redirect:/login";
        }

        long idGrammar = Long.parseLong(grammarId);

        Grammar gr = new Grammar();
        if (idGrammar != -1) {
            gr = grammarRepository.findGrammarById(idGrammar);
        }

        model.addAttribute("grammar", gr);
        model.addAttribute("user", user);

        return "grammar/grammarDetail";
    }

    @RequestMapping(value="/grammar/saveGrammar", method=RequestMethod.POST)
    public String saveGrammar(Model model, @ModelAttribute("grammar") @Valid Grammar gr){
        gr.setCreationDate(new Date(System.currentTimeMillis()));
        grammarRepository.save(gr);
        return grammarRepository(model);
    }

}
