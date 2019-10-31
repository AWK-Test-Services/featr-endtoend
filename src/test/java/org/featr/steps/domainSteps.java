package org.featr.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import java.util.List;

import static org.junit.Assert.assertTrue;

public class domainSteps {
    WebDriver driver = new ChromeDriver();

    @Given("A list of domains")
    public void givenAListOfDomains() {
        driver.get("http://localhost:9300");
    }

    @When("I open the domain menu")
    public void openDomainMenu() {
        driver.findElement(By.id("domainDisplayName")).click();
    }

    @Then("the list of domains is shown")
    public void listOfDomainsIsShown() {
        WebElement domainListElement = driver.findElement(By.id("domainList"));
        List<WebElement> domainElements = domainListElement.findElements(By.className("dropdown-item"));

        assertTrue("Empty list of domains", domainElements.size() > 0);

        driver.quit();
    }
}
